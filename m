Return-Path: <linux-kernel+bounces-126239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A02893425
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB4286DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C51494AD;
	Sun, 31 Mar 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7jYKe8m"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910014884A;
	Sun, 31 Mar 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903267; cv=fail; b=p0J97gS7PxYKZiz7ZeG+hORSCiy3VIH8mN3g7ZT2m8Z9RMGfYOlAabcFoqno74HGkwgvxrBfiUWdl2a/arQ53SxOX3zPoYOGqeYPm6W+RCYM4xO+BJSVZ/EQsx3FV6zhOw6iThiExRLjOS7etMtNle90KH+aahh83QJgnegPc7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903267; c=relaxed/simple;
	bh=O9KnieUX+EFMLqVs5nBZMGQQLdcVb+KLaMpm7Ree5VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LL0RG2OpZHgEn1VPF3O4BI8lDRYBQyB8picLGGDTWan/sSC2qS9AGkrLpPGl8wlGP6Oioq3l+PHzkZecnvZsOP1NINnlD/aaBl50wBZuOlCVQIJn+yDhtAgPGn33HO9FuVdzk/xwbzzFtLc4j+tq0r2ci6J9pzVDuHsOZYea4s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7jYKe8m reason="signature verification failed"; arc=none smtp.client-ip=209.85.167.54; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 74C522082B;
	Sun, 31 Mar 2024 18:41:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzxEQxcMC0M8; Sun, 31 Mar 2024 18:41:02 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2E5F8208D5;
	Sun, 31 Mar 2024 18:41:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2E5F8208D5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 2198980005E;
	Sun, 31 Mar 2024 18:41:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:24 +0000
X-sender: <linux-usb+bounces-8672-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAh2UFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgAwAAAA5YoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 18105
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=linux-usb+bounces-8672-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 616672053D
X-Original-To: linux-usb@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837280; cv=none; b=bOlE62GR0SoJYhmTHz/vJpV2HfRqrlmQ7lF23NjJX9mA+K/8KdM/8wbVJconEDToIJHrFJ6OsCSko5RMaUgnQzWm/c/Lzd5iBg2Pr5vPPjR+RS9ENEYph1jDS7gRopJb7OdckE9nEz2I00wdJlsKXvxnQCq/xDVkiz/8wHskbaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837280; c=relaxed/simple;
	bh=Oc9kcICFBM05I/E/I4AVoBzP2f/9gloPVHobW/2H4Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YQTKIydBv76w12PvQhQQjI3DwHzqSpM+qMI2Z3QxqmwQdMF3YTDwNH67P4SjyWtoplJqTmpRLxFipCb1aKTSu2Tit/R+ldwYxjHREmtGRyPG1Bu7js/BfhkXMeNEZU+WP2gHR/1YxGBxjv+lG978wlt8TkLWc7IxAoDpLRU/dko=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7jYKe8m; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711837277; x=1712442077; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XPGOUCDwaV1EzZ064paZOD8RnQFs1ddJgtwbPEEUz4=;
        b=S7jYKe8msBG0Hsn9CYMRKdMJJSwT1C1KDhNhWuJJHVT+tL8mNXWKFyF+N0xZnPGV7w
         Bk395XN7yob2caKMRGEHJe6VxJAokee7Kuj72ZuuItUajPwWtTCX/PtXOjRFqsIhxjts
         WKUR6aB21G3DVDKrpcp8XrK9Cxw26zWJvuIGkjkr16KV03F3awH9lwtKlw4fenCUcdO3
         LU3p253gOI4kwjlGq6OetGqNdKqLFLukYdPM/lNlK7YfHvzfBF8Z5O570IQA8o7szYfn
         WLR+DJOlOy6aCjAf/IRfozcLCEQurAHZMiYsp9nOqaxvRboDSJywiCRgfsnf4iyxjfLJ
         UmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711837277; x=1712442077;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XPGOUCDwaV1EzZ064paZOD8RnQFs1ddJgtwbPEEUz4=;
        b=mRrp20hY1rE9Eognm9n/d2hAqR5gIU0bP8/gO7Q9JLaPdsA/14nCs8X/QkxAPM3Ub3
         qVsDygDgxR5+RXxDjcPQX/yoQGu8qZWbJihi4edP+rYPPHjl21pvouSqNf4/huMTO/Y9
         D3ffQTcBUhqMpnmjMNgNrXUKTO33/F7DCIfno7sA6ACZBZNf3s91j6iDBW2JBRhV3Ab6
         Jqv44Kwtxc+WLiP3N7hZqvBHL2Lr/4BuhEuCZms4pSm7ECmSq+vWoGfbRxfPNNGSXYeY
         4ijr1njy8w+gTu+w+Z0jIw98O2YzXtvvKnJMg4fSOWcfG9FEevW3YgNdu/yN53HWG5Ok
         2Wng==
X-Forwarded-Encrypted: i=1; AJvYcCXW+7KgZhc0PuOIg0viQolHhZ6s+Nrz3x0rmyN7zGkEM0vp4qkT1Gi5jqpOT0v3/Ho4c67o/Qu9oMk0QetgzAzT656OSeBWx33y
X-Gm-Message-State: AOJu0Yx+swovtAfODejXPFjSCIANO8diQA0cb8vg6fIOCo6dm6gNlJlm
	YrUCqh7tm1flbX01gwt9MZ2WM/sGbkSYjcS+L15Uhejq5se8nHRcOrTJp188hqM=
X-Google-Smtp-Source: AGHT+IF+x3Qdox2g6SjvSt6ZfLOJ3gFe7c5YL+555P/qahnN8Eg7hcDHoGbL+RaMts29GpUddkiBTg==
X-Received: by 2002:a05:6512:3d1b:b0:516:9f65:fcf with SMTP id d27-20020a0565123d1b00b005169f650fcfmr965650lfv.26.1711837276931;
        Sat, 30 Mar 2024 15:21:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Mar 2024 00:21:15 +0200
Subject: [PATCH v2] dt-bindings: usb: qcom,pmic-typec: update example to
 follow connector schema
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-typec-fix-example-v2-1-f56fffe4f37c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFqQCGYC/32NSQ6DMBAEv4LmnIm8kIWc8o+Ig7EnMBKxLRshE
 OLvcXhAjtWtrt4gU2LK8Kg2SDRz5uALqFMFdjC+J2RXGJRQtdBK4bRGsvjmBWkxnzgSatd0kqy
 5X7SDsouJSn04X23hgfMU0npczPKX/rPNEgVeOyGtrm+1bOg5sjcpnEPqod33/QuTXSVvswAAA
 A==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3401;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Oc9kcICFBM05I/E/I4AVoBzP2f/9gloPVHobW/2H4Sc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCJBcricaIiHddrBejVu6XApq90lPrz+UyzOaL
 MmslELd922JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgiQXAAKCRCLPIo+Aiko
 1SnyCACjI3jZcyF8lv/PfbC7h7LpkxjJVFoEqIGjQQ0uJNVnplc27e2UQGG1fpyLbbDQgQEUwP3
 rmurUTUJveKBLHSQJ1fs80Qe9/ZNBZ2YLRBE/vEA5u/RXkKoGSiSgOlSbLk4i2IfXTXWPKHsAyz
 84sJQUpm5yIxaBu8NrAeYw0NnaoMBJEVcJsgrDuGpKUUUhB7FW8fApu+0yroEiMyrtN63xcUV2v
 O2bGuho1A5A6REMw/Xtdr15nkzJC6mbjYg6PxDPL+qy61fuiLlzvN0XxZ/N60JZf39D5ne95O7k
 euRzdwIcCJFYFyYsOMyDhOhTuzIBm0hasGa5sU32VgH8Umna
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Update Qualcomm PMIC Type-C examples to follow the USB-C connector
schema. The USB-C connector should have three ports (USB HS @0,
SSTX/RX @1 and SBU @2 lanes). Reorder ports accordingly and add SBU port
connected to the SBU mux (e.g. FSA4480).

Fixes: 00bb478b829e ("dt-bindings: usb: Add Qualcomm PMIC Type-C")
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Update examples to follow usb-c-connector schema wrt. ports definitions.
---
Changes in v2:
- Dropped patch removing the role-switching port. We do not use it, but
  it can become useful by other designs.
- Link to v1: https://lore.kernel.org/r/20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org
---
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   | 34 +++++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
index d9694570c419..fe757619e535 100644
--- a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
@@ -192,15 +192,22 @@ examples:
 
                     port@0 {
                         reg = <0>;
-                        pmic_typec_mux_out: endpoint {
-                            remote-endpoint = <&usb_phy_typec_mux_in>;
+                        pmic_typec_hs_in: endpoint {
+                            remote-endpoint = <&usb_hs_out>;
                         };
                     };
 
                     port@1 {
                         reg = <1>;
-                        pmic_typec_role_switch_out: endpoint {
-                            remote-endpoint = <&usb_role_switch_in>;
+                        pmic_typec_ss_in: endpoint {
+                            remote-endpoint = <&usb_phy_typec_ss_out>;
+                        };
+                    };
+
+                    port@2 {
+                        reg = <2>;
+                        pmic_typec_sbu: endpoint {
+                            remote-endpoint = <&usb_mux_sbu>;
                         };
                     };
                 };
@@ -212,8 +219,8 @@ examples:
         dr_mode = "otg";
         usb-role-switch;
         port {
-            usb_role_switch_in: endpoint {
-                remote-endpoint = <&pmic_typec_role_switch_out>;
+            usb_hs_out: endpoint {
+                remote-endpoint = <&pmic_typec_hs_in>;
             };
         };
     };
@@ -221,8 +228,19 @@ examples:
     usb-phy {
         orientation-switch;
         port {
-            usb_phy_typec_mux_in: endpoint {
-                remote-endpoint = <&pmic_typec_mux_out>;
+            usb_phy_typec_ss_out: endpoint {
+                remote-endpoint = <&pmic_typec_ss_in>;
+            };
+        };
+    };
+
+    usb-mux {
+        orientation-switch;
+        mode-switch;
+
+        port {
+            usb_mux_sbu: endpoint {
+                remote-endpoint = <&pmic_typec_sbu>;
             };
         };
     };

---
base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
change-id: 20240322-typec-fix-example-3d9b1eca853d

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


X-sender: <linux-kernel+bounces-125900-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAlmUFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 13579
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 23:21:44 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Sat, 30 Mar 2024 23:21:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id ACA1220322
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 23:21:43 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=-5.051 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
	SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=linaro.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llastv2nJa3W for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 23:21:39 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125900-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com F20042025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7jYKe8m"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id F20042025D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 23:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB99C282E05
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F5851C2B;
	Sat, 30 Mar 2024 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7jYKe8m"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB14AEFE
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837280; cv=none; b=XKrIEzcBkBL/hOcL+PegxyE/vNWdtHdDuwO1xpeEiAC6t4vXH2B0UDw/C3b8f0+NEAgaJlQK5NXB6ryHa+1pQbPePD7rFvyDPFh5CQ1Ppc7cZKOYcoOucML5+ZWoBRZOs4yWFiVG+wg2IF6INfMBNjCHeRkOCCMyDi6yvQOp+h0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837280; c=relaxed/simple;
	bh=Oc9kcICFBM05I/E/I4AVoBzP2f/9gloPVHobW/2H4Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YQTKIydBv76w12PvQhQQjI3DwHzqSpM+qMI2Z3QxqmwQdMF3YTDwNH67P4SjyWtoplJqTmpRLxFipCb1aKTSu2Tit/R+ldwYxjHREmtGRyPG1Bu7js/BfhkXMeNEZU+WP2gHR/1YxGBxjv+lG978wlt8TkLWc7IxAoDpLRU/dko=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7jYKe8m; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-515b43b39fdso2560628e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711837277; x=1712442077; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XPGOUCDwaV1EzZ064paZOD8RnQFs1ddJgtwbPEEUz4=;
        b=S7jYKe8msBG0Hsn9CYMRKdMJJSwT1C1KDhNhWuJJHVT+tL8mNXWKFyF+N0xZnPGV7w
         Bk395XN7yob2caKMRGEHJe6VxJAokee7Kuj72ZuuItUajPwWtTCX/PtXOjRFqsIhxjts
         WKUR6aB21G3DVDKrpcp8XrK9Cxw26zWJvuIGkjkr16KV03F3awH9lwtKlw4fenCUcdO3
         LU3p253gOI4kwjlGq6OetGqNdKqLFLukYdPM/lNlK7YfHvzfBF8Z5O570IQA8o7szYfn
         WLR+DJOlOy6aCjAf/IRfozcLCEQurAHZMiYsp9nOqaxvRboDSJywiCRgfsnf4iyxjfLJ
         UmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711837277; x=1712442077;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XPGOUCDwaV1EzZ064paZOD8RnQFs1ddJgtwbPEEUz4=;
        b=xOoYGllKePqUWaEBrRT6/3vclrcBPNz0xLPua3A1z/NguIMM49lSPS3HJ027Quy0MM
         +r3UsVk94vQ3FBH2XPHpauwRvZwq0wQ6u8uItwHEgu9kclNYDkraRHhzxKWjW/qTTS+Y
         o634mb1Aig8HS7fy67clvSnFxw8BAz7iNimpw6Ag2FxWTWgAiM+hzApRtRrMWdRpkeIV
         bWRRRyuiITxiHBVKsF5Aruhuz1YXQIDzNbtEK3Dc8Pesz8Nya5ZTT6TxwMjfeEH7Y1ga
         UXzqFlwq5OMDBhDT20B/wCmbsj2P8K9e+5uqcuTsaYtxNRGwsqwyc74z51AszgXjh/Vj
         N3IA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ya2Zl7cM1YAYRL/4YZRdDSjjSlP4fA8VoE4naRClKtBdM80VOqG8H8JY5gs0uIefefYiFTD3rPwNsGyOgAkHYrdabBIERoDtpR8b
X-Gm-Message-State: AOJu0YwjeEq9ll8717JTBIAGV56NKsvyka31BH5MCNmxe+l2M/d490bL
	4O/2boJ7myuJCoVeC293QfGBuDPNY2VtkTZuqtProgqc9L+/Y/G+7eQUnpJV1c0=
X-Google-Smtp-Source: AGHT+IF+x3Qdox2g6SjvSt6ZfLOJ3gFe7c5YL+555P/qahnN8Eg7hcDHoGbL+RaMts29GpUddkiBTg==
X-Received: by 2002:a05:6512:3d1b:b0:516:9f65:fcf with SMTP id d27-20020a0565123d1b00b005169f650fcfmr965650lfv.26.1711837276931;
        Sat, 30 Mar 2024 15:21:16 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512399200b00514b6e2fd49sm993992lfu.169.2024.03.30.15.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:21:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Mar 2024 00:21:15 +0200
Subject: [PATCH v2] dt-bindings: usb: qcom,pmic-typec: update example to
 follow connector schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-typec-fix-example-v2-1-f56fffe4f37c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFqQCGYC/32NSQ6DMBAEv4LmnIm8kIWc8o+Ig7EnMBKxLRshE
 OLvcXhAjtWtrt4gU2LK8Kg2SDRz5uALqFMFdjC+J2RXGJRQtdBK4bRGsvjmBWkxnzgSatd0kqy
 5X7SDsouJSn04X23hgfMU0npczPKX/rPNEgVeOyGtrm+1bOg5sjcpnEPqod33/QuTXSVvswAAA
 A==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3401;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Oc9kcICFBM05I/E/I4AVoBzP2f/9gloPVHobW/2H4Sc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCJBcricaIiHddrBejVu6XApq90lPrz+UyzOaL
 MmslELd922JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgiQXAAKCRCLPIo+Aiko
 1SnyCACjI3jZcyF8lv/PfbC7h7LpkxjJVFoEqIGjQQ0uJNVnplc27e2UQGG1fpyLbbDQgQEUwP3
 rmurUTUJveKBLHSQJ1fs80Qe9/ZNBZ2YLRBE/vEA5u/RXkKoGSiSgOlSbLk4i2IfXTXWPKHsAyz
 84sJQUpm5yIxaBu8NrAeYw0NnaoMBJEVcJsgrDuGpKUUUhB7FW8fApu+0yroEiMyrtN63xcUV2v
 O2bGuho1A5A6REMw/Xtdr15nkzJC6mbjYg6PxDPL+qy61fuiLlzvN0XxZ/N60JZf39D5ne95O7k
 euRzdwIcCJFYFyYsOMyDhOhTuzIBm0hasGa5sU32VgH8Umna
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
Return-Path: linux-kernel+bounces-125900-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 22:21:43.8207
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 201822ae-4eca-4fcf-da6e-08dc5107c7c8
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-02.secunet.de:TOTAL-FE=0.023|SMR=0.023(SMRPI=0.021(SMRPI-FrontendProxyAgent=0.021));2024-03-30T22:21:43.843Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 13032
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Low
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

Update Qualcomm PMIC Type-C examples to follow the USB-C connector
schema. The USB-C connector should have three ports (USB HS @0,
SSTX/RX @1 and SBU @2 lanes). Reorder ports accordingly and add SBU port
connected to the SBU mux (e.g. FSA4480).

Fixes: 00bb478b829e ("dt-bindings: usb: Add Qualcomm PMIC Type-C")
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Update examples to follow usb-c-connector schema wrt. ports definitions.
---
Changes in v2:
- Dropped patch removing the role-switching port. We do not use it, but
  it can become useful by other designs.
- Link to v1: https://lore.kernel.org/r/20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org
---
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   | 34 +++++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
index d9694570c419..fe757619e535 100644
--- a/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
@@ -192,15 +192,22 @@ examples:
 
                     port@0 {
                         reg = <0>;
-                        pmic_typec_mux_out: endpoint {
-                            remote-endpoint = <&usb_phy_typec_mux_in>;
+                        pmic_typec_hs_in: endpoint {
+                            remote-endpoint = <&usb_hs_out>;
                         };
                     };
 
                     port@1 {
                         reg = <1>;
-                        pmic_typec_role_switch_out: endpoint {
-                            remote-endpoint = <&usb_role_switch_in>;
+                        pmic_typec_ss_in: endpoint {
+                            remote-endpoint = <&usb_phy_typec_ss_out>;
+                        };
+                    };
+
+                    port@2 {
+                        reg = <2>;
+                        pmic_typec_sbu: endpoint {
+                            remote-endpoint = <&usb_mux_sbu>;
                         };
                     };
                 };
@@ -212,8 +219,8 @@ examples:
         dr_mode = "otg";
         usb-role-switch;
         port {
-            usb_role_switch_in: endpoint {
-                remote-endpoint = <&pmic_typec_role_switch_out>;
+            usb_hs_out: endpoint {
+                remote-endpoint = <&pmic_typec_hs_in>;
             };
         };
     };
@@ -221,8 +228,19 @@ examples:
     usb-phy {
         orientation-switch;
         port {
-            usb_phy_typec_mux_in: endpoint {
-                remote-endpoint = <&pmic_typec_mux_out>;
+            usb_phy_typec_ss_out: endpoint {
+                remote-endpoint = <&pmic_typec_ss_in>;
+            };
+        };
+    };
+
+    usb-mux {
+        orientation-switch;
+        mode-switch;
+
+        port {
+            usb_mux_sbu: endpoint {
+                remote-endpoint = <&pmic_typec_sbu>;
             };
         };
     };

---
base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
change-id: 20240322-typec-fix-example-3d9b1eca853d

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



