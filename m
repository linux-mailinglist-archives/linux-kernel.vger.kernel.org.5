Return-Path: <linux-kernel+bounces-46873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE58445AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70BC1C220B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A212CD8E;
	Wed, 31 Jan 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mlmFQn8e"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2C12BE9D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720889; cv=none; b=hYJ7bBwjJl47NbAnRvnoDhT5FfNTqkDkzygUlpYfL81RNEBJaovb5xwV366ocVf7BZP9UodYWLvyLdXK/H/vXxm2Ig06yQGt8AFMQzktNVt9UrIAn1KtLdYEc3o87XRWN1O4e1y5fmEEtZGWhw+kb85KGqlecqV6o+4f3Gum9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720889; c=relaxed/simple;
	bh=FrKnpE9BAaffQIFRBM9a3DlzX2WfYlcOBOsYnXbceHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIWZCgr6V1lLYPDDEnTtnEOPJomDifEQakFdd5QQnrnNVpgLHvQUFRD/CmgKk8pipimGP72Nj0pKTDxtvvCOTEZdJCVUbhG3Bfyci7/n47VeqPWwPeN4PWcNHw9nMlsha5YtY5ojc8/U/FLO2q13uE11TcdXmraxJ1cGWbCiwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mlmFQn8e; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so3672116b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706720885; x=1707325685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsWJv1YW4mhJWkcBD7g/IeRgffr84y0Zx7w3aumJlrI=;
        b=mlmFQn8eKwqYWwHOgfHyqQNGsF6Nb0DZpcUZhUhtMq19vxxP/mq0n58F7FfjWeMPat
         ItAMbadSprSDNi9IHfuhNwXfMbqWS7LwNgK1VcYcmeCthOkHuiGenlql+Nlr8/Kv65rD
         bkGc+KmexC05zM5S72iBTsG4h2JLOBmA6B5awZmS/UZT3leEqipKMqg3v5PyVssoDQ5E
         Ynrkz2vOg7eSTUQSg/GfvXvy5rD2sRhs8UTaNCuVOXqAExKZDTowFjsoMQRE3tqtN/Y1
         Keimx4PQVtQp0HOMJvRy7ah/2pbQflXpn5u2Qs4lY1VfsFIigcDE1UcljflsS4A3TUG7
         ydeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706720885; x=1707325685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsWJv1YW4mhJWkcBD7g/IeRgffr84y0Zx7w3aumJlrI=;
        b=exLZ8l20axu2Z+aNIRj9pkA26TIKkiMJBvsAvgaD0wF7bY7dek9R59jW72PmDzwYrB
         izwQKpjnvuvLp8lFodTtawR3Bxfyzjk7cL4tSU8VGJtxdnfvg2n0wO6HHKqnMZB8OtzD
         t9dKFqKJBuolo15E3mX0+d96oxvnrUtlhTn+2XUUtWKWWYN9m28rYTLL1KRoykCHBRL+
         8Bt4wg8zovBmroe7YxpH9JohcQPr708vefCUFY5VSToeXVyfXbY+o+UuLqEW6la+SkNn
         6LSbGDiN8Rek70gWOolFLmAdefGW6QSp0XMI8kuzZKpzY8B9uDo+1HSXh6xuV5RICl2G
         rUjA==
X-Gm-Message-State: AOJu0YxyMPGiiG2VxhO5jw8IakAgarbAN4C3E+aBhnUH6bN5O52gaAnH
	oJMQUqTc7INaqrshI1USzYw9UsPMoUsQqcXf0aRhtF9+Nnr0NAPS3fajkJafzqA=
X-Google-Smtp-Source: AGHT+IGO/uoytyRUA2AE8MRtQvDYVfhku+fm9eKfM/V9XqUw6q09uZAef4wU1qdeWNORPLtUfnbkSQ==
X-Received: by 2002:a05:6808:4442:b0:3be:a35b:d08b with SMTP id ep2-20020a056808444200b003bea35bd08bmr2038341oib.53.1706720884989;
        Wed, 31 Jan 2024 09:08:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW5pQosX2B3ZPYTxR+xO4xKBgsz9ApnJjaj6SfMCNG8d3wh8LzQSWGpkENbrD5cPpQHIiZQOH7n1FiKuq+zwEKJraNfVwo+hzL3Zsu+jP0tY4tkCl/0UhTZD4tnPywnMDHJ8HIw+pkP
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id fa21-20020a0568082a5500b003bed47158basm48965oib.57.2024.01.31.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:08:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: reorder spi_message struct member doc comments
Date: Wed, 31 Jan 2024 11:07:27 -0600
Message-ID: <20240131170732.1665105-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The members of `struct spi_message` were reordered in commit
ae2ade4ba581 ("spi: Reorder fields in 'struct spi_message'")
but the documentation comments were not updated to match.

This commit updates the comments to match the new order.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/spi/spi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 979cde8263df..61636b3209fb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1113,16 +1113,16 @@ struct spi_transfer {
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both DMA and CPU virtual
  *	addresses for each transfer buffer
+ * @prepared: spi_prepare_message was called for the this message
+ * @status: zero for success, else negative errno
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
  * @frame_length: the total number of bytes in the message
  * @actual_length: the total number of bytes that were transferred in all
  *	successful segments
- * @status: zero for success, else negative errno
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
- * @prepared: spi_prepare_message was called for the this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
-- 
2.43.0


