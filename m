Return-Path: <linux-kernel+bounces-139421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B408B8A031A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B7D1F23CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56E19069B;
	Wed, 10 Apr 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RYdeK15Q"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70F19068D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787286; cv=none; b=iiSoAKsLwH0xnelJG9auSsgurL2Qd4GJXJc6UpRhPchYBtH6+j81fS883/Qf+Mp3Y45BdotWCPu1SRpAs3nJOkErxVnlG9llyqzDoD0f9e0JAQvoTmc37P+5Slyn3dUWTPjUQ4MEoZe4y+Z2koCNsYmabXxG9UupkSuS5HhOqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787286; c=relaxed/simple;
	bh=d/PZVCXIhGvDMuyWk0WrFuAP3smrj3JCHcEtray0wQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJbjuaP2GbLs2O/y50oyKBuLspUODwAiK8bQnw50SOb2FJJP1Wsnq+FW7E3X217VUS3jxFp2cFXjix5mSxljsAy4ffDa/4qtThJ+8DLF4tVo3IfQVji/qmWdPR+6ZK1F6iU3qKMtr7A2M/fVY1/P4eabN7jbgckWetvGt+IItRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RYdeK15Q; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-479e8e4ab6fso1717442137.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712787284; x=1713392084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d/PZVCXIhGvDMuyWk0WrFuAP3smrj3JCHcEtray0wQ8=;
        b=RYdeK15QafMgA85JjH67MhD82XF5EOU5MZv4xC7ZJ88B6jaISMR4a4iZNVDmOlwP4l
         UVfxKa7S4mEpuhpuR875BQYDCjLnOmpPYWTSFYhwXLQMLuOlItgeoDKyN9s+vW8uJB6t
         449hOyyHCfX/MwcEDfQ9F49WIzIk/Kv+UH7g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712787284; x=1713392084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/PZVCXIhGvDMuyWk0WrFuAP3smrj3JCHcEtray0wQ8=;
        b=jbkkmXE8XsNHBTholQwmTfpynLna2sZ/XNjNAPUN4SJkeExzu15n2E5FOAuHxDGUjI
         zNz0bjIfnCgPidKS9EC070eS1163DuaXYzIOHe5Gq9mVF3WVlNGSDu6Y1sI26meXZ7RV
         g4eiTskF1SkXrw3xEeZv9PsNMvGE7n721sh8An/aV/mz8xDP4CvU4Mp0Cm9Q8ODmUaoI
         bpm1ZDTLk6nTqs5cdJ4FtCd56/agRefWVQgQuQPSsTeQTbJW8HNJKYvqDewoHtDKyRjC
         ezUYDYU280wtdRiKjIe2ZaL/YeuLWYRXefk3QbAbCTCtMx2XxDG9q3hT2XMQe3tDCE/s
         vvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzX7rpuNAnpkbUToQuIdPOzUbxkTvMihIDQHAgQuED9u0tI00bDkqpfd8HTQkFieiEXDbOdG35aYGBVsK6ZnVsXmC1UMUanZZwx41A
X-Gm-Message-State: AOJu0Yw5W+I4a0f5x/D8ZWy7pTyoLsi1dnyiOVZPTNU1JrPV3e7tMKve
	Xbr6ewzmCUzAH/0SsT0MvbENRS5U1s1q9ogMZ4tTXUig4YSQKSh9auFVv4w982drjfBeUwUbrpu
	A5TH+gwpQIkTYikiR6TDk/bC/dUmo2f6ZSbywrz0MbtDJ17Q=
X-Google-Smtp-Source: AGHT+IFrChd80DZF7LJFx4Xkr2ghYzNtJ/zfR0j7guxDmH4LX1rsmKz3kvZDB9H/NExqbeD9Jxe5T1Yp+TSqQ6v4FcA=
X-Received: by 2002:a05:6102:370a:b0:47a:26ed:8483 with SMTP id
 s10-20020a056102370a00b0047a26ed8483mr2845023vst.14.1712787283771; Wed, 10
 Apr 2024 15:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409-public-ucsi-h-v4-0-e770735222a2@chromium.org>
 <20240409-public-ucsi-h-v4-2-e770735222a2@chromium.org> <ZhUcu1k0Cum-IMVQ@google.com>
In-Reply-To: <ZhUcu1k0Cum-IMVQ@google.com>
From: Pavan Holla <pholla@chromium.org>
Date: Wed, 10 Apr 2024 15:14:07 -0700
Message-ID: <CAB2FV=7PWffxLR9yVq2MbVijEesSavKiXFT9ZKwJzDi3SnPQyQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ack to all comments.
I plan to upload the next version after related EC changes land.

