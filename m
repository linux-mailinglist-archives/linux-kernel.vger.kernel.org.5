Return-Path: <linux-kernel+bounces-35624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE37839452
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD68B25F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A26166F;
	Tue, 23 Jan 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="XdFawFh8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B50612ED
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026175; cv=none; b=AzjsFaIYpQ7KZ3q6nvoIygtBXg684zt8yCsXreZq+2FxPN2NojrR0NDU6kFEp2CsDSehi5rpcmlUeYAn+0ueCRfnRNd1zBUP45qH7eAVP8jh4UVfj6ecskgROENkSW1aSuJfGvrCfkfDn1J7MRKNYubioq47gEkb2QStqgnsX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026175; c=relaxed/simple;
	bh=9U2brUPHD80W+M0UmveThmhS2M7OTYLb/dG2HmvsAu4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Fpe37JcyR7qwYQy1UPQf/n8kBHzYqX0+SZfHFYixQ4qoog1MAAZlvKnkhKBhH9LugefpdHN1IT4LGmpHZikIejjz7l0JiDS5H5Nz0D0APHx93dgSyjVTCcTLofkl4V0FHNgnem0d+XUexM+q/iywHgkO6CYB3EzDVhsrmd0ORGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=XdFawFh8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51008c86ecbso864910e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1706026171; x=1706630971; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il2ElxRNzWyOW/OqtXsEs39fOt6ojB/hy8eo1dob0o0=;
        b=XdFawFh8oHD9PXb42jWYuAOfHxPAzEcbOtUF7WKynU5ptR+VQccOuHCazHiBeWeMf/
         V+RzUecs+91CGYQ/+fgc+Jnb6EdTvS61yLO2CxYVAbzfkiekQUKMYBfXFrodqxoQD4Jd
         D44FgBQz5bOAlreKR0qt1LMkPd0pzPG8Cc9p0oCICAhp+zQ0MeWwX52OnmEI6/2K3HGl
         8LH50UQxAlPWJhtJYFJGHV9lJF3PpN0KBugxYLimd9Hve27P99IUj7XP9ymsc9bpLHhQ
         gZLkBXNHuYR7yO+dUYTYuuKdki04h147ATz8f0KPBmV2HP/RV0EGDU9MQZ618NCokMO3
         ZmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026171; x=1706630971;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il2ElxRNzWyOW/OqtXsEs39fOt6ojB/hy8eo1dob0o0=;
        b=PRcsxC4ne702wO4NGI6XIyh5Wga3n5zHzoa7qj0QKpCnbtdkdvbBwz2cLC7QXFg4v2
         wxfz0W56SV/CFJsmVGxRC1A4FWK+iT2GiOTEh2sUsdQavDDy4/6gi3AB8YeWpoDZK13N
         WrhI2+DKS/aTQ9tffRAdCmJQvCLVnta1uU28rb94iRxG8uj6fndEO00JQNLeddFZSNpH
         VXBhNZjwTVx4iIJA1TjAj+/jfclTvqyzG6mN4q4KGHIjVi7Cik/TA5Uz45RgC1IcJKHv
         QuGtRXp9avAnivAadW0AoNSU5ylsKCmaqRW+mLX69HBX/eoHNyQnVCwoSvlcOu1mgLVx
         RC9A==
X-Gm-Message-State: AOJu0YwCXqUStBP89sm9AisQbWD+E8XTXKQNgysqPrTmiz0O2LJFa1ic
	L/nn8OcfYLRAUxiuN2c2DgRC+rNkA3QYkLtXM/L7ZNbEbOsgr8saHo985owFVpc=
X-Google-Smtp-Source: AGHT+IHw6j71sfnQVGET6XZK2wZu1RpeQY7Ck7bikm4cGXee9ZDOihsHZrKm9SF45FbWWaz4ASBX1A==
X-Received: by 2002:a05:6512:2253:b0:50e:7a04:2229 with SMTP id i19-20020a056512225300b0050e7a042229mr2975733lfu.25.1706026171539;
        Tue, 23 Jan 2024 08:09:31 -0800 (PST)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id q20-20020a0565123a9400b0050e7be886d9sm2336950lfu.56.2024.01.23.08.09.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:09:30 -0800 (PST)
From: Mantas Pucka <mantas@8devices.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Mantas Pucka <mantas@8devices.com>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] phy: qcom-qmp-usb: fix ipq8074/ipq6018 USB issues
Date: Tue, 23 Jan 2024 18:09:18 +0200
Message-Id: <1706026160-17520-1-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Two issues were found in ipq8074/ipq6018 USB support. Sending as series,
because fixes touch the same code.

Mantas Pucka (2):
  phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
  phy: qcom-qmp-usb: fix serdes init sequence for IPQ6018

 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

-- 
2.7.4


