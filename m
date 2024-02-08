Return-Path: <linux-kernel+bounces-58535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2652384E7B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A664E28EBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3722307;
	Thu,  8 Feb 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HdjSLlSo"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3744C7C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417170; cv=none; b=Cz77X8O8p/eoq9tfTGkj02QQuMPZPLq88ym5/89ksqMuH0lefe1cv2Vf/C0UHgNnjuQf71S7ktwdOEDIK7bNdHCsVdRPwk8OQxGxsGzmPDfUDa9YRUgGr/RcOyWZaFoTpbrnoATviqLSWSoOKliBu74wjRbYbGInNsXyKSP1UBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417170; c=relaxed/simple;
	bh=wHrLFJRfnNXUeGVogN8+9OPpwE8Sci1mCOxtvg4QYxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tWDUYl+m56OgOvETNgW93SzGR0L53ydb7Ho9P+lhP0D0ixsyz6iK4WPVt4Q7QKFpxBSmYZbPpBgho31Svp80whNeiB+XH/lmt4xukEQBJzejZKxbyeFTS0SvUU48xW4va0++V1EXFFut7mTQ5GOCggQrwdgUEnp0ljnnO4PPtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HdjSLlSo; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c427cba7a0so906339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707417168; x=1708021968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOhSHI8k2xKwemaGiMogUyPw3fznz8Z4LeXfby4qFPk=;
        b=HdjSLlSowB6EaPGTBSkJxvmtcH53csRnXfB3MTItR/HL0drWyrhznWOkzGRovoZ+Sw
         PTdh73RmckYlm8bjG3nQD5Aw07+mMyVmnlA++4N1Pr/Q6Kb+VGRZxTRMQCw+Cu16ZWUd
         056x3ilF2gA/BlSTYWiombr5Zy0qZAkpfREZglO6yEnSMgdzE2MMjV1Bk3DG7fdaSNCp
         Cr+tSloTqUyerCV0LIE+sUJC0pK02Uaqo5Po22ZLWa8yaQaoH+zR0JC1KGS2YrgcqJF+
         AUM5tmCjd8ZyNsuSeq0h7EeInGNSV63m0WY9uQADLBCsNxqo/DY9K6Md5onzbFcQ50wX
         IHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707417168; x=1708021968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOhSHI8k2xKwemaGiMogUyPw3fznz8Z4LeXfby4qFPk=;
        b=hSaxK9RqZKLRbCNBnP1b/Kc90XrK+shZgn6LtaHsMd/7IL9VQJzxJckJsaXUqPgRO0
         HEZVEe8d0cpoRqG4GoveoxuM6HVMTKoVROMQyl9XdQeYx0OteLuZECW/nitVPNZm/Nx2
         jtzqmxwHrKcxJtQfiiIq85n7cIYBUoocUUBA3rVyqG3iSPTWOvOrRRA88vRgIGZLAeBu
         RHOHFbHvJ4K+XFS5zTjsbuOGgCdfE1oeIKj80CbHoP2Mij2AZDICYLLu1Mqpve3KGacd
         /pL565Ap7BG4gwxloPclmPYDIoYsjOOez5/XaWafWARvFPDdIxA+34AIY/Zeb3XeiYGD
         q+kw==
X-Forwarded-Encrypted: i=1; AJvYcCXZb1Fs9FCVTM9hFFh2IqT7XoHZzAHxWXdVU+vAI1EJH+m0vEpMEoTb3NFvsk9CFkX/EIZqfalwnasMMSHMLeqBpybE6wYQK5tigQet
X-Gm-Message-State: AOJu0YymKzwKnFoGmbtj7I3Byr2cf/gXw/P3g9/O/0Zo1choc2jGMn3G
	p9tcXZEaLMFC7JRT7B0L49G52V/q4PCx8NOFv41pAD8jz6HOHqP7LQWhAAz0H30=
X-Google-Smtp-Source: AGHT+IFUz3Bw6ISDd3GciQ1PkFFh8jMes3QifdbnhSrBnemaIeE1jkbp9UgMWYTHjwPHgVAExcNiZg==
X-Received: by 2002:a5e:c00f:0:b0:7c3:f2c1:e8aa with SMTP id u15-20020a5ec00f000000b007c3f2c1e8aamr525375iol.0.1707417167749;
        Thu, 08 Feb 2024 10:32:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFN35oyK3P1Kl19g4DVSeOHdJqd7hNO/fEF+Zn4banyLzmAsUB9dGTmHJlmPGk8rbasaMLmyBct6zafrB+IPmSrFNfMSJmIjvgqC6BIW/sXung/TkbPIraqxtSnUKoxgCzcR1eTIU2rXeLNPkRpe+cBazdeEfW3xUzPh50tskx/g83+xSWNhgagQt8yuHn0rXntnK3Hom2LBu+VnXBS1N6c9T8kjDFqLuqg0OPZQtOqUj4jiLTWT2sLAdc7ngzJBCXRJoTClL/ugYT05us0HGmMECzo0pJ6mIeZnRw6bKwhdGg7yG7Qu64tHQhCjlYr8CdWDwNWF5cl8j0vwggM4B50jjH0wskBEp31CDh/xkNOz6MhRJ0GX6rk+Dv+jWMWPU=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t13-20020a6bdb0d000000b007c3fbe781f2sm50823ioc.5.2024.02.08.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 10:32:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
 Yi Sun <yi.sun@unisoc.com>
Cc: sunyibuaa@gmail.com, hongyu.jin@unisoc.com, zhiguo.niu@unisoc.com, 
 xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
 virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240129085250.1550594-1-yi.sun@unisoc.com>
References: <20240129085250.1550594-1-yi.sun@unisoc.com>
Subject: Re: [PATCH V2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
Message-Id: <170741716688.1391883.2946265788968193577.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 11:32:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 29 Jan 2024 16:52:50 +0800, Yi Sun wrote:
> Ensure no remaining requests in virtqueues before resetting vdev and
> deleting virtqueues. Otherwise these requests will never be completed.
> It may cause the system to become unresponsive.
> 
> Function blk_mq_quiesce_queue() can ensure that requests have become
> in_flight status, but it cannot guarantee that requests have been
> processed by the device. Virtqueues should never be deleted before
> all requests become complete status.
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
      (no commit info)

Best regards,
-- 
Jens Axboe




