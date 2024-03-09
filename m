Return-Path: <linux-kernel+bounces-97752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EBE876EE0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04DC1F21BC3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2B2E413;
	Sat,  9 Mar 2024 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsb.edu header.i=@ucsb.edu header.b="XrCMyGEM"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9F208A8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709953894; cv=none; b=TE1T4c2yppaBgQg5/q37Xhj0VJpt2edy8LbNv97IXoq+C5HSwm/5m107IzoduwjTFTAIRGs40OiqQUcFr6RR/2kASQfMdIYtOdBEmgIUvPKK+Rsc/crcAXXgaalie2gjif1jNMj0tASFeuMd1/OAVBOtHCndNOPhk/lp+Z/Ip+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709953894; c=relaxed/simple;
	bh=Q6E9+dYSr0fhaeQjSEhHj3BczivbK9viTEpD8N0C3ec=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QzY0j1GQhZ9Ow+ocBF+fnEU9+dfQv1/7/mw4UqeIIDp8CFTvE2dzq83tdzPst7XYxbVUDuZqjEy925EgJNkQoHe1clDTKKTBdI/Ga/nxS6GIunDeokHt6vnD9ywtGB7uOCbTb1MuDnABJj0ueOiwg9kuQtsfl4mTjipkOHcfYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucsb.edu; spf=pass smtp.mailfrom=ucsb.edu; dkim=pass (2048-bit key) header.d=ucsb.edu header.i=@ucsb.edu header.b=XrCMyGEM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucsb.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucsb.edu
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so38683111fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 19:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsb.edu; s=google; t=1709953889; x=1710558689; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NM++cL11vPCn+hCFoCMkkYKOJmCX+xzCAsUEVOz/s1w=;
        b=XrCMyGEMZY5ZY1WRn3R0/VnOaOTxyt0H53oUs7LfrVj9kKwaBTwKVdeUyWiwxOH1qP
         ldqR2WWkrFN0e+j/1LAB67xIWUAb9FtbmBpr2T0jOVG5+bSb5SDTADMAzX8jJ5JEDnA/
         B+/spFRURP9rWk+X4z/up7gMKNBwSqXol2TjoSFPcdnYDKn+Jujmb3sXHXew+00906I7
         6mTclVBGVMS8iNdsMwyh2r6hLhEeM/KLcYUUMkRMNGAakxPoe5Jxy4Q8smo65OdXMF4Q
         m3j7n96XmC42+UbFd/5Ecxc3KdskzcHrwvKD2+xyBjaBE+vtZEcItmTS4C3wsULZ+HDg
         Bjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709953889; x=1710558689;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NM++cL11vPCn+hCFoCMkkYKOJmCX+xzCAsUEVOz/s1w=;
        b=vzF8RiRUQYUPG1hqpYPz+rPJY63PVtreGrxahrQ1sHlolepyjKvDCi7JBXOcR05RAu
         0T+ptBtRuxqwmwdgKsk8B/Ulh4vVzJbrWYqikDXLuywrn3hDYunhDFF5I1/I10HLBjE6
         /ZC1BL12TALhgJE/8AZILHEMP9QcFUprwx0x/qXhhXED6jLudKMmaGijqDI5xADLfDAI
         KdVj8Z8EMzj7a6AEGkM5Fd+1STZHhMpE5ddyUrIoiF8gAeu0s3LgMmZcVe9MtTA6N81L
         hFMq323WqOmI9wDCqbLuFNRhbw3+63q7sr386nZzM7D8ZhzPi3xU7MjMSi7jzJWTbBHK
         sXJA==
X-Gm-Message-State: AOJu0YwNvqzjQwxBz+HQRB9Mcnt87zFZSiakT8tTUrRmXb+VkWNq5PxK
	I1zH+JJ/yBj2oplfgNV4J2eMZJ686pI14kfijP0HncUfCiRUjCRbQ2pRgQMjYUOZWGy0I1TJBY5
	3P+c7wJpoucwZTAcUJXZ9v9qVBs/l9Hl99xNJh6zQlzzYPFB0m6c=
X-Google-Smtp-Source: AGHT+IFAclsq4nqt7I7P4zscgpJ92Q+VYcExoVAvJJHU++U2M8LkuuRdwlDJVKHbxrhGN8/2M0aMG+0+rh4rou4/TPM=
X-Received: by 2002:a2e:8007:0:b0:2d3:dcb0:56d9 with SMTP id
 j7-20020a2e8007000000b002d3dcb056d9mr635323ljg.29.1709953889519; Fri, 08 Mar
 2024 19:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nazerke Turtayeva <nturtayeva@ucsb.edu>
Date: Fri, 8 Mar 2024 19:11:18 -0800
Message-ID: <CAHY78BqCpMQptPN0SMaXuRqHOhYi+wnMEUSTYt7OHDZih4e7yQ@mail.gmail.com>
Subject: Question about unpacking large initramfs (>2G)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear kernel community,

Recently I was testing LLMs for RISC-V on Linux plus Buildroot plus
OpenSBI and Spike ISA Simulator. Nevertheless, given my rootfs end up
being pretty large, 3.6GB at the moment, my linux boot falls short
with "Initramfs unpacking failed: write error". I was trying to debug
this problem last week, but got confused with code complexity :(.

Nevertheless, following my earlier debug attempts I suspect this
xwrite's 2G-4K write limitation to be the main cause of unpacking to
rootfs, write buffer and do copy functions falling. In more detail, I
see expected initrd_start and initrd_end values being reserved at the
start of boot process and being transferred as unpacking to rootfs
arguments, however within that function body len is being assigned to
random numbers less than 2G until the very last moment when it
suddenly tries to write almost 3GBs of data at once. To work around
this problem, I was thinking about whether to do multiple unpacking to
rootfs of my large initramfs in smaller chunks.  Another idea was to
try to understand how internal FSM works and avoid body len to be
assigned to arbitrarily large numbers. However, after I test these two
ideas I end up with "junk at the end of compressed archive" error. As
a result I have following questions:

1) In this regard, do you by chance have any recommendations on how I
can enable safe unpacking of my large rootfs?
2) Is it actually possible?
3) Or can errors be coming from the Spike simulator's side? What
should I be looking for particularly?
4) If an error might be coming from visually arbitrary assignment of
body len values, can you guys explain how the write buffer FSM works?
I got a bit confused with that part of the code :(

Hope for your kind understanding!

Thanks,
Best wishes

