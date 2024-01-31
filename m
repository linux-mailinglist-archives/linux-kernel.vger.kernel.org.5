Return-Path: <linux-kernel+bounces-45950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5302843848
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9371F2340A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9689A58206;
	Wed, 31 Jan 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4kxvlSQ"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C854F8B;
	Wed, 31 Jan 2024 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687429; cv=none; b=KJGree75W2wwxxpKUdPSpzfMUG739Q7V2NSDSC2LyTbHbBaK5xGRiiksh8KcNaJnXoEfsBC4KDWFnoo6CWkk/4B1QMAt1gK5KV8zFC5RCKzLsXmle9yrzKuD64Ot+xYjEAFusORK8r3h0bo74/LBr8oalmK7PivISNwudBWRFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687429; c=relaxed/simple;
	bh=0tOTsazWTcs9QYzc3VNchWmVv4Rg9HgIxUYj/cpbTtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qw9t3qaPy0bv+AWqBivToFPxmoj1UD1Sc6ymU1UBCy6Rp+SmQSTYag800L8Kp3yu2KtBma050LByV8NHA5qcg10tHXqPbx70MXOrdfGmUxVfFwKpDZK/j3HqXChmizOxYPpOOs2wT+x/2n05ahAP242Ih07KX16ZgAKCApciMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4kxvlSQ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbc649c275so2069715b6e.0;
        Tue, 30 Jan 2024 23:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706687427; x=1707292227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dHEweAsyBseNZ/atWmXcoaWQ2MjiSsil4Mz+T/iMO0=;
        b=k4kxvlSQtyEi8bgkhYUFEVDB0YESvPMcYyM0icUGXAwK5i+yocU5fbwu24lvXyFYXJ
         K3todqDq4hIhgq99B8bGjNFfsI5T78/I1doI8u5cAcdzhYSjzeW7UTarZddrTMA/btzf
         ITZI85v2DkPY/HanDhwYufuYbLHeIpRirci0js2NyR8CU7fyHXS9OCdWw3P7xSFR2x5b
         syj3mWElmz8jUqJis37L/H4psObfyiQ8u1+DfZ7CDq9gdOVGxMel/0DDFTDN98plwj+s
         /TU303AS2drByNlRlP42e8L4aw5aw4V0Oxszu2NtOIWsd0TTSRpCZbY8jUG+n4yhqsk6
         uYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706687427; x=1707292227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dHEweAsyBseNZ/atWmXcoaWQ2MjiSsil4Mz+T/iMO0=;
        b=W2zxncKNoerS4LyMWX2sFM8gHFIcsW/YK40Wsz8TOn1lpJzxn4WaCjJrlLX1DnX/4+
         pKAsprW4Pmf0sYDNNhNK5jmTRoa24JDo4VYi2XlWh+uCtf+7YWX2F2F1nAJanMKu+MBa
         Mx5vH6NTobqroZyI1WdB/Idk084qppYkhSsheiLOhdLWlywgnchw474+hH4UBB1bx0FU
         N+BaEOJO7gS6zeh9XZVbp62pqR2JSeiWBmM/wu/5fmb1CefjsT64Zz/U9kJFyKGcmOut
         uNiuUFhIzfGbs6NpwnAY+nB3318U7Y9e0bn3MG16IrTgrZSl5CIG4oe2TEg0v6oLectj
         Av/g==
X-Gm-Message-State: AOJu0YzBJndJbEgEWd7xbLRo4EDykk5jj9W+r8RPO05WIOAHlkjJuRoS
	6C6bw+xEsMCXJ9j1q9vWUtK97Hs2i8RTWOiLaz0ADVyhSwPPd9Tz
X-Google-Smtp-Source: AGHT+IFszCqYspWQPAe3ZB2AKJ7mKw4cdPg8zTNxdFXIGhpX6pOl/XtE91dPsKrtVnzaxA2/+m5Qkw==
X-Received: by 2002:a05:6808:d50:b0:3be:a88e:167 with SMTP id w16-20020a0568080d5000b003bea88e0167mr1113014oik.30.1706687427275;
        Tue, 30 Jan 2024 23:50:27 -0800 (PST)
Received: from charles-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006dde3053cdasm9164953pfi.133.2024.01.30.23.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:50:27 -0800 (PST)
From: Charles Hsu <ythsu0511@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	Delphine_CC_Chiu@Wiwynn.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Charles Hsu <ythsu0511@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: Add MPQ8785 voltage regulator device
Date: Wed, 31 Jan 2024 15:48:21 +0800
Message-Id: <20240131074822.2962078-1-ythsu0511@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.

Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 79dcd92c4a43..088b23ed2ae6 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -129,6 +129,8 @@ properties:
           - mps,mp2975
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
           - mps,mp5990
+            # Monolithic Power Systems Inc. synchronous step-down converter mpq8785
+          - mps,mpq8785
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
           - honeywell,hi6130
             # IBM Common Form Factor Power Supply Versions (all versions)
-- 
2.34.1


