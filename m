Return-Path: <linux-kernel+bounces-128044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EBC895558
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004BF28E871
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13185275;
	Tue,  2 Apr 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJNy9Fzo"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4083483CD8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064440; cv=none; b=kXU6gv7P8iHxaBAOuF4Uiu6uxXbfg4gYWWokdfT4oTmhSSLd/C7q/rjwMDz5lbxC1BSWxdhJbTrJ2nofeLtcGYi63bAUaOd4jMxlhaGfl8gaONG5LfF8Khojx6rlaeHpcmI/QwDHV7AwLKftl4Wfi8BuEV3iLHwWu52BvLtukug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064440; c=relaxed/simple;
	bh=uES943BKWDhEtnE6XL0P/eRbUsfOg6fa3QiSJ7bNaRY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=exB77uOYoMqvwtYNzfQWVuyFEFjGXIQtjo/n1je1mslSHfGk11Oubb1LzDUnqJqEUFi7YOC/YdiTROPHSmjwj2DUoE5pKX0Ux2+CCX1Pz3OB0rxjgphuQIRNvfTA73dOkKWEY7XmrBx5xou+2IKULjkc5EwnGUxz3S/QAV6HCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJNy9Fzo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso683956066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712064437; x=1712669237; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDwciCZRTQDZapTIDTwTOs3L664qzz8zHC9CYK9t3HE=;
        b=cJNy9Fzog/o1JxsfU9qvizMlirOM9t/ycpy7QizVz1kt66Rhc6eGxThDYA4J3KJ4xt
         NuekqMKPHzlPrc1tJEhOTkSGiI9/22krSodBxgQovg+7PdrlsiJ99LEWtorbzLeVF+YN
         ecmzOmgPpXbu/ZvWQEeVHOa5hx+AUFiCaBCobsTUcVyqHu8+yB5Vha/mmEsokRR8xDom
         HcPFjyI4c3HLvFVJDa62rspCKQ1F14wHJCTc7PugVxl6CNf1OVnaCUoj/gNx5Ro32FwE
         t6CXMz85g38y+l0BbPePuSiXd9LX85b0kWpcVB9Jsy+oElkNAfIQBHHyWGNBaPWtO9Yk
         ppBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064437; x=1712669237;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDwciCZRTQDZapTIDTwTOs3L664qzz8zHC9CYK9t3HE=;
        b=UZBdSVtjlzuQqgph+q5dqZt99oPSFPA1cO5fbyOaomivHfww9XXV+xnJ/SInEOOz4N
         t2ldTH7fB7pYGtRS5qoJsQvac9hQj0DU8cnVlgqro++0GlI8Ad/ih0DHx836Gq0XVPup
         pgKblZKvOKkTUFpiPjrzbE7ubGaL4fRSLNz4OITmoNJy0zLcNdJ4l885tqsczw1/vxEj
         OEhTr+a7u08W5ktceF+/wpGyuXSORkYwHo5en5hlPAR5CvC/yC6AcrErcte8PEO9/efR
         ODfOfK9/Y93qLs64MQ9HhhBhyCP+8khqEJ0yRZrQiAEI1h1iYDGenAcalBvnOcNtomRB
         DcMw==
X-Gm-Message-State: AOJu0YxlxR15+KTkX1/dtuc62rPG//bJBEJVwLrmB62Rdfcehv+bZ2Dc
	xIL15+IG7dwn/k/i3J/7BmvSiESh8Pcbnq5/21mQHIxaKKUULlr6
X-Google-Smtp-Source: AGHT+IGkeMCYZa7WLQdbvR9cjFU3ygd7CXGHsqO0KYja+biw6uCBH9ckHPRO8FmxbXfhAUNukhHXtA==
X-Received: by 2002:a17:906:3755:b0:a4e:4336:5550 with SMTP id e21-20020a170906375500b00a4e43365550mr6687741ejc.27.1712064437211;
        Tue, 02 Apr 2024 06:27:17 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id wy11-20020a170906fe0b00b00a4e4a3e69acsm4216265ejb.71.2024.04.02.06.27.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2024 06:27:16 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	rongtao@cestc.cn
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 0/3] memblock tests: fix build error
Date: Tue,  2 Apr 2024 13:26:58 +0000
Message-Id: <20240402132701.29744-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Some kernel change break the test build, just fix it.

Wei Yang (3):
  memblock tests: fix undefined reference to `early_pfn_to_nid'
  memblock tests: fix undefined reference to `panic'
  memblock tests: fix undefined reference to `BIT'

 include/linux/gfp_types.h    |  2 ++
 tools/include/linux/kernel.h |  1 +
 tools/include/linux/mm.h     |  5 +++++
 tools/include/linux/panic.h  | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+)
 create mode 100644 tools/include/linux/panic.h

-- 
2.34.1


