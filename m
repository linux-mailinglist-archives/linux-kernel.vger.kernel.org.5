Return-Path: <linux-kernel+bounces-47116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05684498B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD411F29F96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CAD3984F;
	Wed, 31 Jan 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGl2BJmL"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FE838F8F;
	Wed, 31 Jan 2024 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735675; cv=none; b=ojQV2YMT1nwHHyX+6Um7yuHF8UB6L+xzEE1fA+8acPJq9xaIkggBeua2B47gl1Z0mI/sipZqIS+ejaLJ3ns1fir6GiOWVeVTxP1lsLNDIOrTPT+zSvKCqRMUlUeQKumFobC+k0ZK16KAUvUeg87CoD51G5J/EkAfdKs3sZ298y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735675; c=relaxed/simple;
	bh=ecE9+lRhGVzRojRakumr7hmCpaQlrKborDJ+lsFEI2w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=dwPKWHXZ1JWZPNtI98oeXVYY93lgGWB5yY4OPaqUzfDwXzI8FT34rbU0TwIVi9oKQlfJbmFYJKNRBdjKzk4i3YVsdAQ0K5CzVMpy1wecPQriUrAIdI95cVQyA3a4vBdI1TKZFm+1M56k14bLJ98igWtLmNYFKU/x/JDpCFKoz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGl2BJmL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so219127a12.0;
        Wed, 31 Jan 2024 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706735671; x=1707340471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzKBpTO+yAsO6AKq5s8rWuJxCgwGnyxQPNp5dZtPA/4=;
        b=TGl2BJmLfeYxzd97d7W/QZPjmyj/Is+IAt/ZkFi7S02Mi9LMySwW/XuKTIATHi69Uq
         bexcPbQun28dvMCe6e30/XKj0lIhYdTYVIj1o3niUE0XcCzhdbwXNcedJiF8o624/GY+
         xOYACdTR2ZUFa8FNk8kKbJAYQU+Boi7kLUMqFrCwhntpkxLeVUI67IHtEXmtSpt7fNQA
         IuLPWYjqMMS00kVmgwBQbq/ZQkQw8Dj0iwP+5eygw2S8vqqhucVFqR1ElVzaYsC+NCBa
         m2M2SRlSw7HDSniCfTXwxUoeZBiEw10lQ/OlAowlNTXL8mdUGaw3AAYyyG+F9HBDlv8i
         EH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735671; x=1707340471;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BzKBpTO+yAsO6AKq5s8rWuJxCgwGnyxQPNp5dZtPA/4=;
        b=eCsyCzrto5xc/XimeBrxtwubigFvOKKR8f1ivh2QW6WO7umMJdBkAHpcdhTEAeNaQS
         8RbPFP25qL606jMp17NyG5j1Xk8zxIHuu/9z414VD6jV8GcrV4vjlzrI3+masHzM5c/d
         Hb4ZTigDqLzCBxlrqbjC6GQBJc9Bqcv1rNWSBOQzZNXDn4aAvimHaItwIssLKYK11vOk
         bX62wq1ZlkpSGbPBC+Lu76Uo4b+TGBfAl4kTExpsLFA7CQoBZfB6jU0/RmdQdEcWecoD
         IhQXiHhhLEx2pBornTeZQc/mAuFPzXgyIhuSbh5aP5NpdA8IycB8MzOlE38BmmCzkJpU
         gQSQ==
X-Gm-Message-State: AOJu0Yw4xEK1/pFI+9V9/YFWci/RY4LPA7sAwLLPHCfl1TYBUFPKGFtS
	a/u4feOo2YTQ6MtKMFPUxA8C5SCSwDu4lYtsTHUn91+p77ut0UErVvgDUml7
X-Google-Smtp-Source: AGHT+IGKSAQ0iom5aOWp/ud0qd1AnStLBR0ipcNAgWjoyolxlKbW/Qay9WlmcGjARF23PCDI5a71JQ==
X-Received: by 2002:a50:ed91:0:b0:55f:4ce3:5988 with SMTP id h17-20020a50ed91000000b0055f4ce35988mr1738459edr.8.1706735671176;
        Wed, 31 Jan 2024 13:14:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCULQ33QhABS4n6ZmrFSYOAyDgetml7TCChj/sOPv0oioq5VepLJymPA1kx2NkWnR/s/br7OHudwGBzZQ5lJljEVZ0T8ec2Qp1S80hCa2QJ/ToAZa1YotVwMLjl1ixwuX3c7Cu+05OhCGKZkQey/yuZ2Bw6v0NVp2+VtTGbXGVknaBG1caPpDodXH8w2Gv/zN7o5cVAOiQHi9MBkRsVot/HEcvmJEiKtCss4rKm7VvdBqeNBwZBwqxTaQPORu/gHnP6qcawXXJpcVGjzH6VAlZvH3ErYrVqCokAc/Rww/1Xp80adSwmW4MDgtNtHYQQyyLLEZIyow/Bpq6vIbRaYa5ynGN86YgBNPs9PsrXMZrXxxonkYDbgwwceyhD1DlNa1QtF0buPDCKbvEXuDI4YJZ5Hdx4UPHCsKxRufcd+/SKhB9BYYyvLq2uV94mWiDf7SiE8EzadWm2IkK3USljlB47pSTIfHntNiE46d3ZtXcpwD8jpvymiIPIFkfazQVGZ1ljIe8QguTVnuWOzaum/Qon6g7VEJ826bImqyFkegmo5KHphHZieTr3zht96D9DCWQSFQ43PUzoKevPHSvk=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h28-20020a50cddc000000b0055f384e7530sm2241381edj.32.2024.01.31.13.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:14:30 -0800 (PST)
Message-ID: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Date: Wed, 31 Jan 2024 22:14:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/6] dt-bindings: display: rockchip: rockchip,dw-hdmi:
 remove port property
To: robh+dt@kernel.org
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 mripard@kernel.org, markyao0591@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The hdmi-connector nodes are now functional and the new way to model
hdmi ports nodes with both in and output port subnodes. Unfortunately
with the conversion to YAML the old method with only an input port node
was used. Later the new method was also added to the binding.
A binding must be unambiguously, so remove the old port property
entirely and make port@0 and port@1 a requirement as all
upstream dts files are updated as well and because checking
deprecated stuff is a bit pointless.
Update the example to avoid use of the removed property.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  rename title from deprecate to remove
  reword
---
 .../display/rockchip/rockchip,dw-hdmi.yaml    | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index 7e59dee15a5f..391c2a7e79de 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
@@ -97,8 +97,8 @@ properties:
   ports:
     $ref: /schemas/graph.yaml#/properties/ports

-    patternProperties:
-      "^port(@0)?$":
+    properties:
+      port@0:
         $ref: /schemas/graph.yaml#/properties/port
         description: Input of the DWC HDMI TX
         properties:
@@ -108,11 +108,14 @@ properties:
             description: Connection to the VOPB
           endpoint@1:
             description: Connection to the VOPL
-    properties:
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description: Output of the DWC HDMI TX

+    required:
+      - port@0
+      - port@1
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -147,7 +150,11 @@ examples:
         clock-names = "iahb", "isfr";

         ports {
-            port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
                 #address-cells = <1>;
                 #size-cells = <0>;

@@ -155,11 +162,20 @@ examples:
                     reg = <0>;
                     remote-endpoint = <&vopb_out_hdmi>;
                 };
+
                 hdmi_in_vopl: endpoint@1 {
                     reg = <1>;
                     remote-endpoint = <&vopl_out_hdmi>;
                 };
             };
+
+            port@1 {
+                reg = <1>;
+
+                hdmi_out_con: endpoint {
+                    remote-endpoint = <&hdmi_con_in>;
+                };
+            };
         };
     };

--
2.39.2


