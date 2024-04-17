Return-Path: <linux-kernel+bounces-148955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A4B8A899E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AC51C23AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960E171668;
	Wed, 17 Apr 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlN5N42p"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53A17106C;
	Wed, 17 Apr 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373265; cv=none; b=ri9tnouN7nX7VxBffNzNwFPxgrCqpgkDlBFuNuKS6o6bsiI82nNWwj1RMWFCRcScEtmQWqGS7SgZixoUEGxGYYaksZNw0/kNyFN/Lnwle75JsUUsrWw02vjg5jx5vZmsnW3emSFvrZnck0q+Nr4j/xhXChO15cQl/WJI3R1wXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373265; c=relaxed/simple;
	bh=g7bYmI9z5WPpy0G5QsJtGrJukZj5hsolIddTlKoRjF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AgT89SrZtvmPdQtqCz5KiJ1wxAuP2smdB2ksZiYjpuU53vplx+krqnpcifBTFTDBQyEQqx5tFXm5XURIkf/KHWKst59qpEl9ctn7veksUip7ikn1FK66r9jeXdVewiqNWCgvda9VSwtQ5US6EG6wYNFRKs8hP5ehU6Z+MOcHNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlN5N42p; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-349545c3eb8so1342817f8f.2;
        Wed, 17 Apr 2024 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373262; x=1713978062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B521hDt7nLJljyJEdIYozlEz0F5MRo++dHaSN5wbsNY=;
        b=IlN5N42pYCBD7r5qrrTdiHHWkFjXx9bUS1fSPvBX7LeMwKcpVQkb482lLLUURV13dB
         WHa9c59FrtbwhFiaNbYnZfXKZ//6TBAanV0sDpErUhxe1SJDwRevSPUCKmTbgdxegqEf
         aZcuMU2YAhi1yWWZanJlqSvMWnlzHchp2ynjzXh8yGJS8lcqsddvGR88ZVRGF+Jusaa+
         0rMV0zMYhNLLAbwl7oZRuzRybcq/uD6KTIW+n9eP4k8f6d2tEQLp8JcYf0Xbu4zBqRSo
         w0keQ4P4z0qTwts9xObWrgfGYYK9JFwHcgCVImI1gC4tdI5Vof+3D1QlJEhO9qdpgzU2
         W3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373262; x=1713978062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B521hDt7nLJljyJEdIYozlEz0F5MRo++dHaSN5wbsNY=;
        b=fSvg3qDqYKaJobwhFf7g6DkZqbWYOspekAL5CBk/3HH7snoedXJhoG+UujKiMqhsDK
         6zzMC/njLMvPF1rOo8BIcfzGjBRpf4VC1W3W1zSwpLEb481PeZQWp/HGv7KqGXMC9npk
         8/AMR/k1CR+q7rtrRfZlmzYyk/GC9WPGfXKy7IVF217QWGpbpd1V8w8+PC56BbMkdFBx
         liM0lzRZlwAheVHYOrobefp6Z++26+h9V5FJFfLiZD8xryMdwzUKEUDjB+WIzLUbqKSu
         8EP2wsNFPZFaZ2fo2B2+YoRCaBjH8W1n4tdLqqnwdWu/qj6IcvA93Dcf84oJjPKy6pB/
         0Ggg==
X-Forwarded-Encrypted: i=1; AJvYcCV2uNSPxc54xmknGv91QNV9VkCT5YKD2n+rfZKu1DghwveQjgNUfQXWG1rHaGCCUFKmyjNiW4q9WDrGkFj1svqOxDRZiK/ASGDL6cU3J9OPHtdWRDEJMlbx6xjXYNstleVs/28Gna3nwipJXm3UqSd+XEsbBiYvePsq6XvlXzm/QffKjA==
X-Gm-Message-State: AOJu0Yw6++KrxJYAKd2vzio+bTJkXOEsEaXwSADV9dYB7eVsqBTdkUSv
	9UWy62+Wr7tN07NduhtJmEc2h2FhVyFjMsMMCcugnHL+X9c38aLP
X-Google-Smtp-Source: AGHT+IFBgSLAKnJWy/yoYt0incQcA2cye6eZ9TR41TnhlVmKVN8AHeJkao9bG1Wzye1H+2dHmrT4yA==
X-Received: by 2002:a5d:4104:0:b0:343:bb25:82f0 with SMTP id l4-20020a5d4104000000b00343bb2582f0mr10374571wrp.11.1713373262076;
        Wed, 17 Apr 2024 10:01:02 -0700 (PDT)
Received: from spiri.. ([86.124.122.31])
        by smtp.gmail.com with ESMTPSA id g2-20020adff3c2000000b00343300a4eb8sm17949441wrp.49.2024.04.17.10.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:01:01 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v6 0/5] iio: adc: ad7192: Add AD7194 support
Date: Wed, 17 Apr 2024 20:00:49 +0300
Message-Id: <20240417170054.140587-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Thank you all for the feedback!

I am submitting the upgraded series of patches for the ad7192 driver.

Please consider applying in order.

Thank you!

v5 -> v6
  - protect ad7192_update_filter_freq_avail with lock
  - better bindings description for AINCOM
  - the pseudo-differential channels are no longer configured as differential
    when aincom supply is not present in devicetree, in this case the offset for
    the channels is set to 0
  - because of the above change, there is no longer a need for multiple channel
    options
  - correct channels regex in bindings
  - no need to move chip_info anymore
  - change names to ad7194_parse_channel/s
  - add else statement to highlight parse_channels effect

v4 -> v5
  - add aincom supply as discussed previously
    https://lore.kernel.org/all/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2khXnqA1cSdKpWHKWp0w@mail.gmail.com/#t
  - ad7194 differential channels are now dynamically configured in the
    devicetree

v3 -> v4
  - drop device properties patch, changes already applied to tree
  - change bindings and driver such that for AD7194 there are 16
    differential channels, by default set to AINx - AINCOM, which can be
    configured in devicetree however the user likes
  - corrected mistake regarding positive and negative channel macros:
    subtract 1 from the number corresponding to AIN input

v2 -> v3
  - add precursor patch to simply functions to only pass
    ad7192_state
  - add patch to replace custom attribute
  - bindings patch: correct use of allOf and some minor changes to
    the ad7194 example
  - add ad7194 patch:
    - use "ad7192 and similar"
    - ad7194 no longer needs attribute group
    - use callback function in chip_info to parse channels
    - move struct ad7192_chip_info
    - change position of parse functions
  - drop clock bindings patch

v1 -> v2
  - new commit with missing documentation for properties
  - add constraint for channels in binding
  - correct pattern for channels
  - correct commit message by adding "()" to functions
  - use in_range
  - use preferred structure in Kconfig

Kind regards,

Alisa-Dariana Roman (5):
  iio: adc: ad7192: Use standard attribute
  dt-bindings: iio: adc: ad7192: Add aincom supply
  iio: adc: ad7192: Add aincom supply
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../bindings/iio/adc/adi,ad7192.yaml          |  83 +++++++
 drivers/iio/adc/Kconfig                       |  11 +-
 drivers/iio/adc/ad7192.c                      | 226 ++++++++++++++----
 3 files changed, 274 insertions(+), 46 deletions(-)

-- 
2.34.1


