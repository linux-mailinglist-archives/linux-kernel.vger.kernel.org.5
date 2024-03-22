Return-Path: <linux-kernel+bounces-111017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5C08866FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1CD281E51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB4EAE6;
	Fri, 22 Mar 2024 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQG17hsO"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7ADC8E2;
	Fri, 22 Mar 2024 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089939; cv=none; b=kvfxbzTe0MxwIdNJmdeCOSf6oMPpKdFaotVeqx8JzSMlWt1aYk+p3TKFQCjoXHAn4NYNNlDLoHYmVmaa1Y9coBANMomGiNuHS62LOozb1/2qrVGP9Ay9/o7/PAmnHXil+nuxTOJVWIQ2HeGgbo1+SCnw+wyC9jyadRibQpsN9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089939; c=relaxed/simple;
	bh=/lf0tDQvXRFPt50cWid1RnW3RlMNcFsrS7mt3Xkwubw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gYJAJzHCGLTf01FpQHiInX6S4ofWrTY94OJbdigvOfsM0DwjGnQpeJZNBkEPY/oMU0/T3tLO8BDoVd4W9Fn2dVEcM0/uckkGEbefURtznOYRlM9qpmc7WOy8NNJhq5GNa5rRg9pPruiSw3nj9amBoHEvFSUfkycVgYKpmCaoDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQG17hsO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46cc947929so247641166b.1;
        Thu, 21 Mar 2024 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711089936; x=1711694736; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ui2/86gYMRmJflyA3uO46uowsgpBJaLyEk39FOlIr+w=;
        b=ZQG17hsOyVigXsWBn4Gakscd26vEhfyrj+rBwJOlhiOqLHV+0ykQ0RyCpPy+h6iRD6
         gWSR5xM3sI507gFZJuGB3pyEFqHllrnp+W5Vm71lmW3fKPQjxyEXonUfgWZz605LqkwH
         9LM+dwQ6GH+LU49aC8KhDd6k3qLdPbJW/RW9Ht/vBeVhtg66KthoCbX+rpC4lH6NFLst
         IqnG5S6UvQM+4HH11ioA6pKhVAHJmA3ZicXbqql8HmIIimmQOOrtqZxi2hmRaJL6dGPL
         7Yzurh7hUVugQUlJfcMvUDO3rKEJSkDzwPiODZAUWiM3YPu3+Dz8G6YA0KujmqyoGWwC
         AOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089936; x=1711694736;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ui2/86gYMRmJflyA3uO46uowsgpBJaLyEk39FOlIr+w=;
        b=R1QC0p8khCAUi53ZzpeE/SeAKXVjtb5G1r1daVl8ekcN4DJZOlWELA2WJnl863cQYP
         FUF6sSEqhdaqL7SQRaUhHZxAjBbJR9Y4wz9T0/L1Rof81BltFGh4LRMZIiT5QTdylveq
         yNIHvJDbSsEmouettLClUlFu01wUf9yy9GGmPIc0C1PbZoYwFH3/XDejF9JRMEE4gZX6
         MdbSoRyeICc/TlfSUJettmPfpc/M3pVRoa2kpZUfVNcQazf8FMqwO26TeL/osfT4GQnW
         YyWGJ0aK/IgjByDApumQG95+l21rbar+rJfpwAfzdlnB/v82qHdu35VCB4LDBDDRi6GY
         umYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC6o1CRtxOAhcwGsfIEC/6qXn7M6KGBKyU8GZTzPoWb/fdDzSV+fD9pTx/wODWA/ATfb0j8D/+FOnQP7UsFNQbyhOFLIvZBcTfgKuFLWLDvNI95vuL7dpWuL7OHuTmlsTrAAZdCAY3+Q==
X-Gm-Message-State: AOJu0YxEAkkmnXyeTO+VyjzOKn72jRUWPx3vJFX+KE6wx3E8tdcQd9Xo
	FaGQ1wgUnsmT378apV04apTHBEudIw0Ks04TCtsGoYaD2XefOrSX
X-Google-Smtp-Source: AGHT+IGtFzN/gx9AFNKUy9rg+o03MkxUw7k8OBf076+VwdSjKPVBe2p5nZFPIt2uvPzL3RYH0jwxwA==
X-Received: by 2002:a17:906:eb08:b0:a43:f267:789f with SMTP id mb8-20020a170906eb0800b00a43f267789fmr948688ejb.41.1711089935743;
        Thu, 21 Mar 2024 23:45:35 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906375300b00a46bb8a44cdsm679694ejc.198.2024.03.21.23.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 23:45:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/5] dt-bindings: hwmon: convert multiple devices to
 dtschema
Date: Fri, 22 Mar 2024 07:45:25 +0100
Message-Id: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAUp/WUC/13M3QrCIBjG8VsZ73GGH6tcR91HjBCn84XU0GHF8
 N6zQScd/h94fitkk9BkOHcrJFMwYwwt+K4D7VSYDcGpNXDKeyo4Je7pY7hNS9bOeEVO9iBtPzA
 mlYJ2eiRj8bWB17G1w7zE9N78wr7rj2L/VGGEkuGohWRUi0HQy+wV3vc6ehhrrR9LIkOmrAAAA
 A==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711089934; l=2069;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=/lf0tDQvXRFPt50cWid1RnW3RlMNcFsrS7mt3Xkwubw=;
 b=2McnvuoHUuUtyQYvJUEBSnqDqQnJ2c+n4tSid9GmqgqV0Zi9e4tkHLv2pe+8MbsJr3uSAau/w
 yu/hjQxdwhkDr6+Iz3JBjASswg0ktvFhZOYsYhqCwUWzDO/UB4e8+YF
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following existing bindings to dtschema:

- as370
- ibmpowernv
- stts751
- ibm,p8-occ-hwmon (moved to trivial-devices.yaml)

Additionally, pwm-fan.txt has been dropped because it was converted a
year ago, and it is not mentioned anywhere in the tree.
I could not find the rationale, but its current state does not seem to
provide any valuable information.

The binding of the as370 looks very simple, but given that the reg
property is not a single address, I have written a dedicated file for
it. If reg = <address range> is valid in trivial-devices.yaml, I have
nothing against moving this device as well.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- ibmpowernv: fix compatible string in the example.
- Link to v1: https://lore.kernel.org/r/20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com

---
Javier Carrasco (5):
      dt-bindings: hwmon: as370: convert to dtschema
      dt-bindings: hwmon: ibmpowernv: convert to dtschema
      dt-bindings: hwmon: pwm-fan: drop text file
      dt-bindings: hwmon: stts751: convert to dtschema
      dt-bindings: hwmon: ibm,p8-occ-hwmon: move to trivial devices

 Documentation/devicetree/bindings/hwmon/as370.txt  | 11 ------
 .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt | 25 -------------
 .../devicetree/bindings/hwmon/ibm,powernv.yaml     | 37 +++++++++++++++++++
 .../devicetree/bindings/hwmon/ibmpowernv.txt       | 23 ------------
 .../devicetree/bindings/hwmon/pwm-fan.txt          |  1 -
 .../devicetree/bindings/hwmon/st,stts751.yaml      | 41 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/stts751.txt          | 15 --------
 .../devicetree/bindings/hwmon/syna,as370.yaml      | 32 +++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml       |  2 ++
 9 files changed, 112 insertions(+), 75 deletions(-)
---
base-commit: ebc9bee8814d12ec247de117aa2f7fd39ff11127
change-id: 20240320-hwmon_dtschema-7f58f49118aa

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


