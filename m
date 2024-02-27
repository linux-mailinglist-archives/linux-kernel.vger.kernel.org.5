Return-Path: <linux-kernel+bounces-82474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4214F86850E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738441C2179A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819671859;
	Tue, 27 Feb 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxEr2dFE"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956F7FF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994348; cv=none; b=saSpLdhEltK2ps+5+RTKoGA2VVOFStHO+DJw1tZVSQf1LbF+rtAwUSfOZX5F3YTNtjLk0iIaUFc+5Q6pn9FxWZm11DQUuASkOC9PHbbNWjjAGA/ng1DYCHOLzWkJl3mxyGZ4HejfbDEUwEXPVsVUaaufA5bHQigHS7QwJhRWmPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994348; c=relaxed/simple;
	bh=AhrhA0X8avLtGyybofw8r1o+S07uog51OtbaDma0OpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL4U1XPjr7DMBhkhp3JfW0vBqanJle3v3Z0fsZpe0IMD7kEmq7ENNVIbfA0erXe1hUmeFrw6jNNgwPc4EFcx3DUVeYQAmaU5UOaF4Vawyw402pnD50pBpopvlbQBj07tJLnS3HomODAQQOOtsYYgxPXGzyqfqhCXhPS/4sm+/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxEr2dFE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so13335e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708994346; x=1709599146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AhrhA0X8avLtGyybofw8r1o+S07uog51OtbaDma0OpA=;
        b=UxEr2dFEwcUavdUPR8MIesb1pyxx7G1tkQKMfQUrDoxs0C5+rAyCWK/HlXoX+AUryZ
         ZRcXlUMXuyus5SfvYo/9wlW9/NhMfebjUzMFYHICx9hYFGgTt5StAiYhM1UDpPHG1IW4
         V1HawqvwXp+gxx9Q8hYWcri+ST97kRKPImhLkrZTHRGKSYww6H2I0vcwKgqexdoOzDp1
         ztQNP7nX9uaPoHT7PqmtoWQrqMVlpw4aELlDyBaGf/OGMbov/SV/lZrxLqsNVASXreeS
         Y49KekUN7gZsX8hjrjLVZkE3vACciVRtxkbk1rS1JBamTZDx+25qlg0iN6bG4YmKSUWj
         WTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994346; x=1709599146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhrhA0X8avLtGyybofw8r1o+S07uog51OtbaDma0OpA=;
        b=Po4O2xupiDZ2/1cQYpXOfvKtPQxF55oQ73zadZgIl7gTs7Nl5DL6HlHhPA+Aq7tqZY
         I6rnO1tqzBBr1lW0xuB9dBG6LW1mOPtG4trVSxXJ6dvbAm8cRIW9olA6nRxCxkNGlHz8
         fop0EroPXyV8kqvKzCPDwLoTWG5we74wTVF9jNlXUzeyC1pKilKOYIDhfyN5wwX1HsDY
         PxB9vNPAqrOuHlTQeiT/KI8OhCNrEheNBr8n3bNXQOak2FsnJq54rq6/14Xg70srJbxv
         /vlbUrpTWBuhnKu0qKMm2l++Lf2jzlGMo961WLlOHEerjM37VnRLmzDfdzWm1t5iTdp/
         9I6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1lS5mySs2Y6zE/qof3zX/uJqTi5YIDt235qsweJq2ot7nKdrk3UQHkE2V0Xee1iox1Svm+oNbtI4fna2QU6GstvEZgdWa8rC5BzWQ
X-Gm-Message-State: AOJu0Yxf/WWm7gUwmVci5+nT2Si3eiAThzwyYRVTrur2HGS2+Hnws4r9
	8ujEN/Rsl4Sd04KFlhi5YkvIrxy/r3rb19IMEXkPD4pUAu3zA91ljdslEXaMUPLi01tZSIk4Sxi
	UOCIgTQzsMm9F3H+UwUsmKdYkjnf956oly7RU
X-Google-Smtp-Source: AGHT+IEnyBDnhYmsBfNFkYuwY2a3M5LFXYnqw6HaS9U6td/mUiCJUzbjhRP86gOsUbFbHfGuNU8aNOrZNbdM0Ay62/M=
X-Received: by 2002:a05:600c:518d:b0:412:a390:3440 with SMTP id
 fa13-20020a05600c518d00b00412a3903440mr49520wmb.3.1708994345708; Mon, 26 Feb
 2024 16:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com> <20240223010328.2826774-4-jthies@google.com>
 <CACeCKacHYxdvdzaRxRMREeXWfbunhSy-3q+sSKHbJ+u9XXQukQ@mail.gmail.com>
In-Reply-To: <CACeCKacHYxdvdzaRxRMREeXWfbunhSy-3q+sSKHbJ+u9XXQukQ@mail.gmail.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 26 Feb 2024 16:38:53 -0800
Message-ID: <CAMFSARdAOTbPpiah=aqk6DFoNLWahdquSrPNXQmAiALKOCAxhg@mail.gmail.com>
Subject: Re: [PATCH 3/4] usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
To: Prashant Malani <pmalani@chromium.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please consider using two commands to retrieve the data. This will
> allow you to support UCSI 1.x too.

> Nit: I'd probably call memset before setting con->cable to NULL.

> And the same here.

Thanks for your feedback. I'll apply these changes in a v2 version of
this series.

