Return-Path: <linux-kernel+bounces-52445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443C584984B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766431C20B65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974DF18029;
	Mon,  5 Feb 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="LkIRMlDX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF5175B9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130970; cv=none; b=LHroA5xTT2f7GMhr2Z+DYgijojQpav0PuZvBrnUD2WLQdGDmjj5rCse+8amxUT7hjb0LRc8hwnsuyFO1fo8mshFrt0vwerWpFKfzOt0XyJfa5GkXhtJDB1mvIK8XdHQJoj7yZtlHMBIdXewbxbbFa6uAiPZfLeymlc/45571aVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130970; c=relaxed/simple;
	bh=t1iQC4pQM9CCMqYQd7YKM5jtdsjZTdnmCoPImZwqAeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cdy7yMb1I9qGZ5hQWkn1YiQapBIIaWuVk9je+tfzzTe0Un65MhbeU0Nq3ftOD5ocJMye0vuY0gp4uPTszJXQsjGH/JpZ+BnPeCo0gWf4l4wME9GN8lHQiK9RUrCyRLRLSR9NZUO0nXWEFqYXSjl2xW3nSdpDYorCRIaonGn8XgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=LkIRMlDX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a293f2280c7so559248666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707130967; x=1707735767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l19YYrnnF3BoAWJZcZHFkvAqU1sKKbjwzAbFdJIwVmk=;
        b=LkIRMlDX1gD2/v7zJheDng2Gpor26Dnutm1M+6A2q6B9ai59iaQmUoFOUoUxj0vadL
         J/WWW/klOR+kZAOQj/xHYf3Kd5+LUYV958x6Vd55rUhHhB8PiwS8b5aK3ng6qDXgJNYU
         FAE/vvT1NK0lZAHqxp9XRBo/EX9y40yhFuyU3scjjnv0AbhscBFlTQUUpLoXibHPxHrx
         3UATQrV6sOiV5HMR6JhSwemmukdDAtwz5xcSWb3qhfj+EWIGU+qfByKU22XxfUIPRaCq
         9TvUAZUtetq8CV2DHU6RhO59k8XpvapAmlR2ijsoDYjC4aGujRXAS7b2/I5BIwW5FbrN
         VU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707130967; x=1707735767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l19YYrnnF3BoAWJZcZHFkvAqU1sKKbjwzAbFdJIwVmk=;
        b=BoXsh8nh3PWye6W3eXujt8RK+N3bQUXH4EcPUpa/IRUg8W/KjHm6DD+4S06g49cqX8
         3jGcDlhfQAKcWYTEQrBNDhpV6OueEuesWKA9So3XBXYGN4s0YmC1Oa6h/y7gQ6j0sIXy
         nIgJCtQSjom/vefCFKQyeZAtYhIQz852Fsqe630GwPfrGreBd9E7abMqlB9W4y9GAp5B
         nPv1+rAr2YGeWVod0RZ7y1QzTKwNLNe49NCe4nD1LEbL7DHGHczIIPRlc1Ncrq9r6vpG
         PLqpXA+xcFLaEyFDZTYc26aSQIvMLtv9Oz1aHBb3PUUG/3scKIU6EbCAGyvZMSiQ3M7O
         o57w==
X-Gm-Message-State: AOJu0Yx40MqbDXhtoiUUHO2z8vKa2hTt5r8789Q3N/9aOi0DD+0DFFoe
	UqltmHPC4S9MTTRsatnMd54ghHJVAOWrW89Jph+Adms0y4jPcWytYM6dYdZE85Q=
X-Google-Smtp-Source: AGHT+IFgEkIe+H/dSblunqbmoT20fIDDVlATcRcIL0ebcdVRNFf2GyvomqgIfToBWUQtD4sKDPZO3g==
X-Received: by 2002:a17:906:1d6:b0:a36:fe5f:12ea with SMTP id 22-20020a17090601d600b00a36fe5f12eamr8479645ejj.11.1707130967156;
        Mon, 05 Feb 2024 03:02:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVTs93FijpFw8Mv0LqGuDhBTEzGqDZAotEiUKHELKotGXcevPwUfkU+uK+cjlI1XXK9mcFBq7kStrpROT5A7+5RcIud4cS37DNtxLiNT0YWrGsa8s4f13Yp1vCsP3FmJPhUJJw0XDwicoEtAyXNnl4Nx4cx4bhPP2U/GUJAoQKgUusEi11xGT7JFyZLihHIfrughQi6XFROXbICVPHGD6QYAFYy/V0s0L5qyNn5uDLdH6Y5KG7AhMIe7Ar41Hvtx2KT58/1bsla4Bu8qzr9bqQSkQW2+m8OVjs3LJNPl1nZbiWglu9rtj4wjycokTT8cVsE
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h5-20020a1709063b4500b00a37624d003fsm2525111ejf.121.2024.02.05.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:02:46 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: Update pattern property case
Date: Mon,  5 Feb 2024 16:32:43 +0530
Message-ID: <20240205110244.676779-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver expects regulator child node in upper case.
Hence align with the same.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
index 0da5cae3852e..43c7f7f8d43f 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
@@ -66,7 +66,7 @@ properties:
       Properties for both hot swap control/switch.
 
     patternProperties:
-      "^sw[0-1]$":
+      "^SW[0-1]$":
         $ref: /schemas/regulator/regulator.yaml#
         type: object
         properties:
@@ -110,7 +110,7 @@ examples:
             vss1-supply = <&p3v3>;
 
             regulators {
-                sw0_ref_0: sw0 {
+                sw0_ref_0: SW0 {
                     shunt-resistor-micro-ohms = <12000>;
                 };
             };
@@ -144,10 +144,10 @@ examples:
             vss2-supply = <&p5v>;
 
             regulators {
-                sw0_ref_1: sw0 {
+                sw0_ref_1: SW0 {
                     shunt-resistor-micro-ohms = <12000>;
                 };
-                sw1_ref_1: sw1 {
+                sw1_ref_1: SW1 {
                     shunt-resistor-micro-ohms = <10000>;
                 };
             };

base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
-- 
2.42.0


