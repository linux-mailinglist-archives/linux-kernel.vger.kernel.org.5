Return-Path: <linux-kernel+bounces-151081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB838AA8D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5AC1F2227D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA42F5A;
	Fri, 19 Apr 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QRuMp+In"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC563B1AB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510196; cv=none; b=NzlwhKPFVp8xAnrRKjHsp8pfD5PVUnltbVgMdvDIjjQRB5qLDmyJcHIeYdeDNmPq/GQAHqfvt6DRy5uxTmPcgC6TM30gL4WFx9VbOnYZucUpJwP6VNkCyN8qk5gD5H3PUgdWu6hZF+23jt8gzjSln3b5qV45b1GrmeEKcQImCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510196; c=relaxed/simple;
	bh=1KrvB4xP70N8g9WohZTwaHNc8WTwZCpkVPlckvQf3UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtGHAbFvGg2j/RypuJOEKBpgrBMMXqhIGZvekysPJc83KSAACXlJqYkDcsIvXUDoh/WWEDs7My8y+6UL/aV/gLfPFJ6BZEPkbO7r3Vh7F4YP53paCQGdEzho99t6StGwF9EbGLw2rDDD6bxzNTulFGq3bdY2eluHqfkBm4aO6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QRuMp+In; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so1992671a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713510192; x=1714114992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1KrvB4xP70N8g9WohZTwaHNc8WTwZCpkVPlckvQf3UQ=;
        b=QRuMp+InEmSVlRLbshacp9Vb2Tz4uWaPjwi+g54DcyYLbjwVZR5NjNSRvhC+Mq56Lm
         RSfX0P7cg3j4t358ZI0hjCN5csrzAzZFUk2Urb4lQolkXIHlHGwC8cnEdwwmSfMWspXW
         owoKFFfxPJfjQ/iuKWVR7qgKwiniGS2NHsqYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713510192; x=1714114992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KrvB4xP70N8g9WohZTwaHNc8WTwZCpkVPlckvQf3UQ=;
        b=QRibIl8MxNFs9r+FYokmlLiWqkBRsnh7jdgMG1/T0SZhVbgwLQca+2x4pEJ5431dXh
         rw+KwGDHVX12LCVfGBqIvBvdh4DbXyt6wAtRgIUuMwCdRHff6WiYXexmezvFGxd3ZQ2Y
         Wy57HlMyohB0tEhVsN28TTdMatQeSY0jIcO6LoZIHvDgirdckRemB4kaxYc/mYTH3s+w
         a7gMSBoqABotBolSjKhdUPsih+ZNk6mjQjRL7kFhHKcEnukFEvI862S9dTT+bd9nhLqe
         jyprMjb2J31nAzmEYoC1WfC2BUF7ZWoHvZ1+QgHnL2SG9OX/WTsUcfpujI0VdfKYqcTh
         Qy1g==
X-Forwarded-Encrypted: i=1; AJvYcCVyWZ+dJ8h1Adt2fww4U7NRkOTBs6Ukz5SBXjH3vtZ9i13WFRNx9GGjDOtl3mG6YNu+ALs2B659HYTkKHkoVrICiNmYJL5bDClxC9Ex
X-Gm-Message-State: AOJu0YyaLogRVxO9HqlUlWVjO0qEiG4lf2Cvcppq7FyHnPwbWF6gA45r
	3pdrxsk1TyUZs5Ut2cZlnAiF9eEYdjdSPJZhi+NOnzlfWcUN3onVoFNlmkzl+h/z3te6Q2nvX1D
	qBpnsJb69qWY1YOejVzIn9of2/thFpczz/wIaaw==
X-Google-Smtp-Source: AGHT+IH3tRDQTulqCGMpfmCAFTFNH+od70SwwdrUrSA6qQtwCH3uw4FkqvfBp0PHrarTrt0l/Vxtc1TP3mMpHSe8yDo=
X-Received: by 2002:a17:906:298a:b0:a51:98df:f664 with SMTP id
 x10-20020a170906298a00b00a5198dff664mr784164eje.76.1713510191793; Fri, 19 Apr
 2024 00:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002615fd06166c7b16@google.com>
In-Reply-To: <0000000000002615fd06166c7b16@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Apr 2024 09:03:00 +0200
Message-ID: <CAJfpegutFNPRU+L0XAyryRETL9_qbcKj7ARBuTzgR4tnK8sOiQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in ovl_nlink_start
To: syzbot <syzbot+5ad5425056304cbce654@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: possible deadlock in kernfs_fop_llseek

