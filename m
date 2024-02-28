Return-Path: <linux-kernel+bounces-85177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B66486B1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D671F298FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BB81586FC;
	Wed, 28 Feb 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QVkJQ6YQ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63097157E9C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130230; cv=none; b=DUh5YsFH0JxjGmYZ0jLcBd+ZKAVXg03+PwPmTi+zOKxqdfcnTIyh+eUaTc9h2GqkpkF4QNIr14NBDrpB7I+n1jCVVymllht2byTCdELrz8SkEibQOmJCJrUBCEDJ04WJ5cvIvE/DGWGhP7KX3HtPMreNmmWkppwQTzR2rhwDzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130230; c=relaxed/simple;
	bh=6eDB0S/OrI8Jim2nC1AIiSSV+moHRJ4iRBCSZE0fQXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QHA8rGpk8DoU/dofNAvZCPgKFE+NsGbdfiOYGkolEB96jzgbcnSZPk9W47GHe5rvBF1ZZkQKw7vZzQh3A06WV4+/iFo1xBGQkA3agZnziK+KHsNbRvXxytzclVG3AephrJ4F2GkUDKQH4ZnGODLm1lokCqntfs7IrLAznBuZKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QVkJQ6YQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1db9cb6dcb5so6474895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709130229; x=1709735029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjdeObJUnBqQu6HDkte6fjDlmS40A7iu/FBjW2fna/Y=;
        b=QVkJQ6YQee9ByADQ2tM+7k2ek5J0J62O3mup8JyFYfL4VUnP/KLsd6Be3Ma4hMxsWR
         wGVZyQx9OibCkeGVlofB7W8iJEIHvCvCoG88GWK7BO1WzgmWFHwPia4WGLEMkYmIafBR
         4dlRHRXzsv9sLcl1VY3QQPVejx5EXY8z+/J+2YECqWsDittaJzT/7gk5MjG4JAvd9xc4
         i685JHyPZ4Z2+pZ4mttVGGv9TA4NP/b3YVu3FOwujBLffjAS8H+PIu24FL61RFmfPJQ7
         Nk47PqfdQcKuETuXjHCIoVkz5pnG6Ng4io6GY5MciR/i594pULLSlHaD/afRPIgBxX4v
         F7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130229; x=1709735029;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjdeObJUnBqQu6HDkte6fjDlmS40A7iu/FBjW2fna/Y=;
        b=IaEmamld5OgEKudiG6HkTZk1D++HRuzRwh5novFvpzM1fKATGY4kyIRCsLmByxRcgY
         SXfEm9B2g8ejZ4B7sKfjeQIUn652AhaXFXcslgBoYozuMdTu2i9m8keGPmX2fvAq7zr2
         NXDRC8n9HgOoYxghjlJF9KZSwaiKA90MpbMIo2ISb56XdRZ8gNWGwjy8T6WRf8yvqD0K
         LGuKty6wJq8JJrNM8fM/ZC46g4nDvOXUMlwBDZPqROvnfIZbSFhcAp6pv80P402v/2Sl
         ttVM8aWZhpoYwVWSH1o8gXp8+P7FIiT2x+Q/cv1Svcjekk3+hdGN4R9jxRYiI4YPMC3V
         lqVQ==
X-Gm-Message-State: AOJu0YzwC8udP8Ne+n7lN997RANzoqYeCXdhHSYj0dxImvNpbsxgsp4c
	oemCHJAbZd9rIEtaMg8BQzfUdhNOeDi3BgfGt3GXZ4KzHlQ+rt8VA9Ee7GPpCM0=
X-Google-Smtp-Source: AGHT+IH/MjPBIo7j2BjB44t7chZaGLE+a6b/kZ9NB4qyJwnZ3JvyhMj4NieH5fmVBR6dNET0IR/11A==
X-Received: by 2002:a17:902:e98b:b0:1dc:82bc:c072 with SMTP id f11-20020a170902e98b00b001dc82bcc072mr12897760plb.1.1709130228686;
        Wed, 28 Feb 2024 06:23:48 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902b10600b001dc96b19616sm3375375plr.66.2024.02.28.06.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:23:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, Xiaobing Li <xiaobing.li@samsung.com>
Cc: linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
 kun.dou@samsung.com, peiwei.li@samsung.com, joshi.k@samsung.com, 
 kundan.kumar@samsung.com, wenwen.chen@samsung.com, ruyi.zhang@samsung.com, 
 cliang01.li@samsung.com, xue01.he@samsung.com
In-Reply-To: <20240228091251.543383-1-xiaobing.li@samsung.com>
References: <CGME20240228091258epcas5p2a1ca7f77ab84ce3041b08d63c411412f@epcas5p2.samsung.com>
 <20240228091251.543383-1-xiaobing.li@samsung.com>
Subject: Re: [PATCH v10] io_uring: Statistics of the true utilization of sq
 threads.
Message-Id: <170913022728.171956.6622482281428725824.b4-ty@kernel.dk>
Date: Wed, 28 Feb 2024 07:23:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 28 Feb 2024 17:12:51 +0800, Xiaobing Li wrote:
> Count the running time and actual IO processing time of the sqpoll
> thread, and output the statistical data to fdinfo.
> 
> Variable description:
> "work_time" in the code represents the sum of the jiffies of the sq
> thread actually processing IO, that is, how many milliseconds it
> actually takes to process IO. "total_time" represents the total time
> that the sq thread has elapsed from the beginning of the loop to the
> current time point, that is, how many milliseconds it has spent in
> total.
> 
> [...]

Applied, thanks!

[1/1] io_uring: Statistics of the true utilization of sq threads.
      commit: 4c73fd7498f75e06462e94b907e9cc79e0726e0c

Best regards,
-- 
Jens Axboe




