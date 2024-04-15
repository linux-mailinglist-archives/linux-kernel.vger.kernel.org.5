Return-Path: <linux-kernel+bounces-145393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 324858A55AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE437B23584
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38C374BEB;
	Mon, 15 Apr 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYNWo0TZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8C4C618
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192944; cv=none; b=O/urNXwOCbMbUtOhg1ni8iuQ/dYwucV+/J09//v4ftP2tCGQ+c5dKxxcV7TOT7NGVKp24b2J7NqMVeIGCc6N/jWhnI6nLbI0KOm7q5+iztSfqi0lRePVRVu9rowl2K41gNluD0yYtkjt0lHxlQlqlXP8kIrGpTfIT3+JbjEDkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192944; c=relaxed/simple;
	bh=WDkHaDtxUMhuf+2FTTK9mP7/Ztpa7Ckmr7AB9otDlZQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K8JIfheixgMZgtThFkW3yuUdCRMDI5PnXXQMbGMDg+HhOTAf5wtDaLWxDKk2fAxaQY9BlTxHssYQJQjpQlT+3iXsmpLqaUpG+R5/jDAEivCseJJyTH+p5Yk6uEBXk99TolorOz/LIJZBDZS0isw+ZYmJx5959uzJvLSmE53yuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYNWo0TZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d2600569so4094386e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192941; x=1713797741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPVyNDZXIVGtBPcXZSh5720WZSR/h3m9bCoSPbXJwY4=;
        b=XYNWo0TZwkEpvINd6TEqSPVUqyPQEp3zp+9k3WkgU0UllR9xhh9z+Yentj8+LRue+8
         BMxYy3h7ubTD7dbm4slBWqHcYH9XcqiTdFKZZTYkpFrplAdpJvgDecy3JTOy43WYzT1V
         JMrSKG4nHubLlE45FBVV+1RQsX7MQQ4O7EO8hSf0lhwvVlSU7mXgg03cpP0CRC3pK37+
         xRpKSckamF23C7q+l+afi8h+NwoXEaIhws7/RbA45oVqsOfF2vumChtNZL/Qd0I2/ke0
         ja9PBDJNaLx8VfCS4GPENFRMCb7rHYPQxJhywUd3k7HtZIVJ1jg+fA3Hompyu9N8hbVV
         h4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192941; x=1713797741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPVyNDZXIVGtBPcXZSh5720WZSR/h3m9bCoSPbXJwY4=;
        b=fr7Lp7mvlOcLbH1z73GMtoW3SwqKb5/ypmsYMRgM8/E8mL5Ey1RB+LK5RdLOeQ43bX
         gCm6Ywolx4wsP4GVmkyqLVz+htfmtEYnW+0h2T79IrZbDX1UyLlVTOcyIAnoGxaywMRP
         UORVcRr3LOf95imaKLtoGongm0z5xEETeYegyf7HKhAK7ceGlY+xd2cxxspcUL4CL2Bb
         8XgttlhganhrjM5UjWpjmwg3RAeh1XxT6vIDX2CoMYTqsCMTFc11iPID/YM9lkAQd8VQ
         aS1Y2maEzhIACONVEkqbyu9ZTPioLWOUkZYNwS8DpMgQbEufLkqkDzfXpk82OJnXE7TD
         ZtHA==
X-Forwarded-Encrypted: i=1; AJvYcCVY8cPICB/KG2v6wtzqnKOCdMo3Ign0l7Wj22ufyAHigqRoyQuKn8Pgv1AA56LdOW7GoHEw8zK2paWrBsKSAw7bsvcpprIHtuzlKzhP
X-Gm-Message-State: AOJu0YxTbKdj8Nh1FZlrOnqLwAr8neQo4btY6lIMsgEcM5YjsEVAj69C
	vq0y1R2xf5vGsPt5ILhv5igmQ1g9/8XEicPQUb0YJkYtrZYffkfZOk/lULFB
X-Google-Smtp-Source: AGHT+IHv0ugznvbPYFHNo5KQDouQtOZXFfgZyNbXLK8tVy6n3ZeCul/npbGQqk7sQaIUMAtS1H3SPQ==
X-Received: by 2002:a19:e042:0:b0:512:f6a0:1311 with SMTP id g2-20020a19e042000000b00512f6a01311mr7719210lfj.47.1713192940445;
        Mon, 15 Apr 2024 07:55:40 -0700 (PDT)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0056bf6287f32sm4893415edd.26.2024.04.15.07.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:55:40 -0700 (PDT)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Subject: [PATCH v2 0/7] Improve performance of 'faddr2line'
Date: Mon, 15 Apr 2024 16:55:31 +0200
Message-Id: <20240415145538.1938745-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the second attempt at submitting this. Version 1 can be found here:
https://lore.kernel.org/lkml/20240311204019.1183634-1-bjohannesmeyer@gmail.com/.

I was looking at the performance of faddr2line and noticed that it spends
most of its time performing two tasks:
- (1) Making redundant calls to readelf and addr2line for each address
  (e.g., it makes 7 readelf calls and 2 addr2line calls when converting 1
address, and it makes 252 readelf calls and 51 addr2line calls when
converting 50 addresses); and
- (2) Calculating a symbol’s size by unnecessarily looping through every
  symbol in a particular section.

This patch series consists of the following parts:
- Patches 1-2 reduce the total number of readelf calls to one,
- Patches 3-4 make minor changes in preparation for the following patches,
- Patches 5-6 reduce the total number of addr2line calls to one, and
- Patch 7 modifies the symbol size calculation to only check two symbols.

I evaluated the performance of the patch series by running faddr2line with
a standard kernel image (X86_64 defconfig with CONFIG_DEBUG_INFO enabled).
When converting only 1 address, the patch series gives a negligible
speedup. When converting 50 addresses, however, it gives a 15x speedup.

Changes vs. V1:
- Correctly handle duplicate sym_names

Brian Johannesmeyer (7):
  scripts/faddr2line: Reduce number of readelf calls to three
  scripts/faddr2line: Combine three readelf calls into one
  scripts/faddr2line: Check vmlinux only once
  scripts/faddr2line: Pass --addresses argument to addr2line
  scripts/faddr2line: Invoke addr2line as a single long-running process
  scripts/faddr2line: Remove call to addr2line from find_dir_prefix()
  scripts/faddr2line: Check only two symbols when calculating symbol
    size

 scripts/faddr2line | 110 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 26 deletions(-)

-- 
2.34.1


