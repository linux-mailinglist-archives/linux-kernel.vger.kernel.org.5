Return-Path: <linux-kernel+bounces-120132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA888D2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179013244D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33513DDDE;
	Tue, 26 Mar 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHi+9s4f"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2F13DDB5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711495194; cv=none; b=JBTdUAjPHtFwZSS6KWXCfQ7Bh4iKgjzMyh4+vdFoi1jcpzYUfcpajYolI6gTsAy9G6qhqcGBjL+PTdtZjxD1IqW018pq0gAa1BXaCf5ivf1LCoTgxDgT/CJwQQuRz+I3AKFMMqBOqvctPi1GTZuDypgtSZnVVMlTiPbg9vlxUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711495194; c=relaxed/simple;
	bh=UvWP6b18kN8mm8jE4MtS1uYsAsJWVUOJQTXrlWh4/Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NytfoNdYdPgLg1Ew01hg522y1H4ZbE7lS1CfBqb0VCQCDuI/ip6BImHVO7LmJ6138Z4C6ZTnZwqcukaD/BpF3+4KH9yw/QX+R9GCtVJzjT9i6tH24KJ7vDDqIIUxmOV1XBWsXItLCP7Wasv1GNW8s3HL2GiujPdxb10b4NJDS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHi+9s4f; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso1966a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711495191; x=1712099991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UvWP6b18kN8mm8jE4MtS1uYsAsJWVUOJQTXrlWh4/Ww=;
        b=nHi+9s4fjgUhzmzjL5pNYUo/1/mqTXL1Zx12yzAM/khDBJJXHuqhi3LyLkkIAeWo0a
         z+koTPXaIg1U/sBBPhBJKs1mzopqlbOaFWYd9pDo10eGFdPEHyL/BazF1OAJWzvu3m6H
         jd0t6lmlQrvz7IEqn9S73gypbDeJmUNOZwxqvNZy1Z3wHjtfP/KWc0l/OtV3o08VSflt
         Q4cYMttsixEqx6cLlVhviFbzPBYLbuHL3COzt/LpX5Gss0DWUWTkntTu6nNXSnVX/AFF
         nf9UABeE3/LYij3wpLe6EPSAKzhuI0t7RrpMl7qG1IVjyyjiP7FvhUBZO1zTnoqbW0KX
         lLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711495191; x=1712099991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvWP6b18kN8mm8jE4MtS1uYsAsJWVUOJQTXrlWh4/Ww=;
        b=nQgpq0LWEtZDpH8SJH1tsobVqhVdqFmkXalMgJE8EPycuS6TEZoD11RAJbw/eMFIkH
         /YfzvFS8ZIVFs1tNy+zm+obPH7mEy8JLSv3yenvcdlbm3A3U/jZjhDiw65XZG9241VHT
         K8jVnt0W0RY+uiw+41Ke2URZP074dIKRkDgxA/hx4NKK0OknFQx07vM4ZCxrC8UZaKek
         kp+dpcbuu3Qu7ABSomkGaKfIaQjW2TMb5zPST2KcYQlqZXjo97T8AvajNcnFI4RL3lO9
         NVp51Rv9xOLyyxWb+0EzgD3akYpyHmSRcHBA4gpuGDgTblEjmIF+zJuBkp6zTvpTAHIC
         ZE9w==
X-Forwarded-Encrypted: i=1; AJvYcCUz5C2zVea+T7f0Uj/KFjRoLW/KAirbphwQ6l59jW4HneBsSMmp0PuruUZ2TxaL3C7a4fC9Hq8FDHdO0MkYaDYgvFfMJD3/5ZlS3ikF
X-Gm-Message-State: AOJu0Yy25A/JuLaMOZQnK3rf+qT6ZPnz1wJ4H/e6YXWFM5FY0Xd4J5+3
	EJSnGpP2Ozp1/EwNjlCC/s/xl8X61+yAUWGpKnXJTAMQ1nv8keN1g24V1d8M6vUGb0nRbw6PZVF
	EupTOqkmFdIvzqkkKVF5PVs5ZO0TY7zlOoLOP
X-Google-Smtp-Source: AGHT+IGZWut7iYxsRXsNc34sf0qz5fmBiwVI3r+NknfdcTh9appFJDXacDvZoJGMK/rXWQcZT5jiuuBFscfiEQScH5M=
X-Received: by 2002:aa7:d910:0:b0:56c:c20:6b40 with SMTP id
 a16-20020aa7d910000000b0056c0c206b40mr19214edr.0.1711495191346; Tue, 26 Mar
 2024 16:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305025804.1290919-1-jthies@google.com> <20240305025804.1290919-3-jthies@google.com>
 <44e8142f-d9b3-487b-83fe-39deadddb492@linaro.org> <20240326220919.GA2136359@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <20240326220919.GA2136359@hu-bjorande-lv.qualcomm.com>
From: Jameson Thies <jthies@google.com>
Date: Tue, 26 Mar 2024 16:19:38 -0700
Message-ID: <CAMFSAReKmon7xAXWq4kJvN4Ge-tKkhUaaDZFP5EZA-=WU5oL1g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: neil.armstrong@linaro.org, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,
posted at https://lore.kernel.org/lkml/20240315171836.343830-2-jthies@google.com/

Thanks,
Jameson

