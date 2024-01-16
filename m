Return-Path: <linux-kernel+bounces-27601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A782F2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121FA2870B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A581CAA9;
	Tue, 16 Jan 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uye0HLSl"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0501CA9C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424319; cv=none; b=Nve2DAB/GJ3IvVh58y4ibNEqfwXQ5dqZGkf7iIPWyD7auf6z+Hiv3I8llG8IcluGjwfR2lvfyi2Z29y+3gdBUfYmickc4akCSIYtQTSRlOU7k+87ehrDowLt5AkbEFfETw0UZYLRm/4Li5hs7ZzAATrwaRQ0yc31PU6JfnTNots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424319; c=relaxed/simple;
	bh=EzGq4CAIyuPivzAKnK9cT206XFZLx0RSCBYeBqadKqM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=ATOc96AyvDmraFANutlwmWDBnaVgDnEo1K1PwOUvWvoi0fVNA2/yeZ7zHG4KzHx9plshs7KrXXba3MfGNxeVYBvSTiFmkzqUIahSWUZ14m1HMDdfq1Zv1sNu/31M9mkePDzyZ9LhpphxKTD961EpdFtiOxQcAdJRkVH7KCBt1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uye0HLSl
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso96697639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705424317; x=1706029117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lvta5bGdKwksZo0+l1KEGWg49E9lz3g/VdkEuYjFXQ=;
        b=uye0HLSl4kwVOhyvJrG2NsIqrZQDiceHim88KBTXa2ojTktbRP+DbmiwtTlFgo0hP1
         ceKPILk2f/F1WiSJurMv30O5jYCZjZR2Wi+6EWnc+SQYjR1ZkNFSNmewcmqdkzzpsSHr
         KXougct4jGsU7fYYnIB7I4ivSLJrdYyx0w8+25GgkSVgIZ54u8tv1au2l8i2dOAERNY4
         DSbxqKsUWp6Aet2nhaviCXRk8W2QGKIM8NHEVXuj71rtmtjEM/grKA+cKn+7fupa9ZvE
         mmFQuSz+kl5WS2JOo5FvUqN22uFsTgopGNQs175BxvNbKrZTaJSVicIozLfXPEg5limP
         K6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424317; x=1706029117;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lvta5bGdKwksZo0+l1KEGWg49E9lz3g/VdkEuYjFXQ=;
        b=jWUXTdbz4fYktS/vazpRF73XmkwC5S7JRIVVuv50Rrx8KOC4MHgAddJMWB06gVc5fV
         qAiZFSiJf+lt5YOm5Qzq+b5mP0c1WxCzaSd+SP9VsqMtLDLJk1QR2j0Ut8oUbENlI4D3
         r4joNu9+sP/iyWJtT9E8arAIzZVDFzW+Ag5Y8hBCeW0PcpJBxQME7fjJz7ckcFzpR+Yk
         c0KrOseM0Vs1dk2PDRa5u+icv39qix5F3WFm6bSJbcw4JvdFy6wtIm+3dXv8Pp3ikEDT
         3JeX8vbuQ2cL2WJv07ULaDaW9XGqR+Q0rklxIiVU4+oobOhgJWeOAV08rxkAf19FxqBH
         242g==
X-Gm-Message-State: AOJu0YwsTPNkE61zLry+dQva2z4v0GUUYTmP3+e9jFns6R5iqUsxElaK
	bb0M3CIA8swmdFihgdSp8Q/bpKV0lEaHRA==
X-Google-Smtp-Source: AGHT+IEjtSTkxVzMVFADP/Qqq8E5bXQZvkvA2xVWQ+NExmQCm+K6BPI49WHSYQ9vpnvZdYbfmFl8uw==
X-Received: by 2002:a05:6602:14c7:b0:7be:edbc:629f with SMTP id b7-20020a05660214c700b007beedbc629fmr13678177iow.0.1705424317488;
        Tue, 16 Jan 2024 08:58:37 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r8-20020a056638100800b0046dfd35b042sm2995191jab.73.2024.01.16.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:58:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kemeng Shi <shikemeng@huaweicloud.com>
Cc: djeffery@redhat.com, ming.lei@redhat.com
In-Reply-To: <20240115145626.665562-1-shikemeng@huaweicloud.com>
References: <20240115145626.665562-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH] sbitmap: remove stale comment in sbq_calc_wake_batch
Message-Id: <170542431569.238046.5650778720274078505.b4-ty@kernel.dk>
Date: Tue, 16 Jan 2024 09:58:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 15 Jan 2024 22:56:26 +0800, Kemeng Shi wrote:
> After commit 106397376c036 ("sbitmap: fix batching wakeup"), we may wake
> up more than one queue for each batch. Just remove stale comment that
> we wake up only one queue for each batch.
> 
> 

Applied, thanks!

[1/1] sbitmap: remove stale comment in sbq_calc_wake_batch
      commit: 5c7fa5c8ad79a1d7cc9f59636e2f99e8b5471248

Best regards,
-- 
Jens Axboe




