Return-Path: <linux-kernel+bounces-74188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7D85D0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72150287A90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A93B797;
	Wed, 21 Feb 2024 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkQfgsQD"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0ED3B78B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499288; cv=none; b=d/n5IuBRG7y6TaEpNRjGpu+O8klnK+v8FNrmS2fvKpxzhOObtoHlMaZmJLEalvot2IwrhFa0+oFQC+gYWQFlmlUdqobkUq/Bcp1RFKj4H+ne7Qf5coEdaLdfQdLGc2kbQJ67r3EHm15gtpw7i0kSCI+J5e2/SH2E7q1wvUAFZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499288; c=relaxed/simple;
	bh=L6zbD+r4iAQVkolpUdqaC5kdIDlOZs92K4PNPYeqx8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vs186qEZ5D9z5WOqCJ8murJvrCmpseUmGQFQAU6mLhxTJ08x+oEprI30tAGkZfEZdWmNjA9s9g+9PWLcWxzUfNliEwPBV8WxRmH5UzB/rkAcXYyFulNmAzQaAs+jNOLTtXD1GBnI/Zi2PGpCGHhfzF66HDlwIoVaKi3OstzdTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkQfgsQD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511976c126dso402590e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708499285; x=1709104085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L6zbD+r4iAQVkolpUdqaC5kdIDlOZs92K4PNPYeqx8Y=;
        b=vkQfgsQDHrbxG0DiaoWAnw8FsfnbUdtZib000uWHg0wIlYT+HrgSStHuiYTFUcJX+e
         WxuIkK2ISklm7coEPKp5c4WxJ1ItMjJcaNB8ViHy0TMQQou9LBHAhK8lNrXNP1UFDnmj
         0PC0tcY6HTPeoetxu516Pf+mF4jHWA3jzFvgNzv3dSdg4L83oGnRoGj6PvPKG0wgqado
         oXMgHUNtdrh61hAjN49nc9F36tiScy25yxpJYLLhwKySzAuU9+zoHH24k2aRZOjzq/n/
         jgDtVQNmz3Cy8icJcJZdMLlt0wqpN9qNPWLCE0UozdxYIJUcxYOwIkkojnyKbpr0Qq0+
         zRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499285; x=1709104085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6zbD+r4iAQVkolpUdqaC5kdIDlOZs92K4PNPYeqx8Y=;
        b=KaCBIJPMdnpTdHLplxAnudOukmt7SVRbOFiRe8Uy/ON1aD64SNrQgsWt+fHWX1y372
         AKdKW9qaOz7zd3L7N3MrAOz4zAjLDGlaYuKQomb9w0YoUaO5P4FfsHRDejPAVAHU/xfr
         KIymzwLqnAVtF34cpLIErwrXI9NklTEQNbRM5hEUnaKxuhdVonxC0ODCIqIRUs+WuCKD
         U1K2uukQrDLi9a1yxFnyp66eFYTsg3Iq2uwm9bK80zU9tTb/FW/yMQ6LCZL/bNbYHFMY
         n3SspL/uYhZtQPaMOL8UDbQPkuN5a6q9tUxDdihLLEfTQQD0wqoKR8BAA3V7rGd0XAG2
         qWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8nxpI3SCQ4CpE+9dcK/G4vAf0mQ+p4aGL5i4Dq9/u4IcL0AQjTG9rZbuf/80H9Fa8QaN65nAwpBXeeU1LVFzQMaJFbUUldZWDxVgp
X-Gm-Message-State: AOJu0YzjOh/n8BfccW/1t8u42qC54eVu19XEC/6TCPvI73vVe9W7srGM
	b7eMeZ+JcuZ234cQ57/pBIdfIA1cQFtRybePaEbshHf7KdLpPDuIUFgHLPuuzzbqza7Sf0kLATm
	H6+k/vws5g4yt9qL2hvMOJLNfib2DpDqCkqT8
X-Google-Smtp-Source: AGHT+IHa365tMHI74PcJwpoL4by21xl2KdQYoT7uJGyPBKgsElto/rB7Qh2SvL3fkLhg7dgdD64D4s6+6hqom1eKg68=
X-Received: by 2002:a05:6512:2107:b0:512:d6ca:71ae with SMTP id
 q7-20020a056512210700b00512d6ca71aemr61918lfr.31.1708499284887; Tue, 20 Feb
 2024 23:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220191114.3272126-1-dhavale@google.com> <6c2d5345-98bc-49b1-adc7-bcc349a0a6bb@linux.alibaba.com>
In-Reply-To: <6c2d5345-98bc-49b1-adc7-bcc349a0a6bb@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 20 Feb 2024 23:07:52 -0800
Message-ID: <CAB=BE-Se6nO_VTncA9CH7k65xRPtyxo=xSH__i_OhV8++LfEYQ@mail.gmail.com>
Subject: Re: [PATCH v1] erofs: fix refcount on the metabuf used for inode lookup
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, quic_wenjieli@quicinc.com, 
	stable@vger.kernel.org, kernel-team@android.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> If it looks good to you, could you resend a formal patch? Thanks!
>
Hi Gao,
This looks better and more readable. I will send a v2.

Thanks,
Sandeep.

> Thanks,
> Gao Xiang

