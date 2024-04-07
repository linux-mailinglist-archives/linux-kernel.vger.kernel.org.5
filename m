Return-Path: <linux-kernel+bounces-134298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C859689B00D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352471F221F4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29B14A8F;
	Sun,  7 Apr 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZXScU5+W"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C0185E;
	Sun,  7 Apr 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712481616; cv=none; b=UkIuQ6ejlaHjRfri4ja4Viu0T6gUAn80SE8TwYNe++PzBGtLwSjyhkZxsgpgPRWpT03h4QMm3/g6WZ/cRSFSC9jXy9VYP9JW1gajjIrfHH+abP25P6Hq8b7X6dRfdlwzO5jYq/+AGfJXElxS8XAbuxxaMKzCuwfyuegWKhRKHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712481616; c=relaxed/simple;
	bh=qwyLL2lkopXXldUtbaJEpS8/YGSSO7mnIlpQcvDLSNU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qta8eukHoZCr1wLCVeHdEvw6jxDTMgYm/ZmKBybRSYVJvVIZ1+VazStI6Q6iVCaJRV+EgQ3PBTBP2it8dSguwnLPGsJzR6QtZjvLfzhAQ5oIju54dx9WxnR+Yrr9ApSPs67ZEXccbRdb65SzSouUS4e8n0RPcdCf4VbKBPZXuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZXScU5+W; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4379Ixdt040509;
	Sun, 7 Apr 2024 04:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712481539;
	bh=BXUirUDRwUKvqSotOrO17BUK1Jhx8Pa4Xbxk/9g3eXg=;
	h=From:To:CC:Subject:Date;
	b=ZXScU5+WMqpUWsSVOX/TLL2Cx7yhc6jEsZyRxUBAVPd/dRLf8O7y8HMZxz2j3UsqR
	 MjAAA4ichIIZfCSF2u3EuIfAEBlZcLTplvOxqkTv6IXhSeC00yk/o2WOffJTs/jAv9
	 nXzaVAyex0sdFAzXXwV7kdLaa8dJCvYc6+MSmQCU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4379Ix7Q115892
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 7 Apr 2024 04:18:59 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 7
 Apr 2024 04:18:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 7 Apr 2024 04:18:58 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.144])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4379IpWl079280;
	Sun, 7 Apr 2024 04:18:52 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        <Baojun.Xu@fpt.com>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v9 0/4] ASoc: PCM6240: mixer-test report
Date: Sun, 7 Apr 2024 17:18:41 +0800
Message-ID: <20240407091846.1299-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

v9:
 - Retest with the code with Volume kcontrol
v8:
 - use some reasonable format of changelog.
 - fixed the format of subject
 - remove *** BLURB HERE ***

mixer-test report:
 root@am335x-evm:/bin# mixer-test
 TAP version 13
 # Card 0 - TI BeagleBone Black (TI BeagleBone Black)
 1..455
 ok 1 get_value.0.64
 # 0.64 PCMD3180 i2c2 Profile id
 ok 2 name.0.64
 ok 3 write_default.0.64
 ok 4 write_valid.0.64
 ok 5 write_invalid.0.64
 ok 6 event_missing.0.64
 ok 7 event_spurious.0.64
 ok 8 get_value.0.63
 # 0.63 PCMD3180 i2c2 Dev3 Ch8 Digi Volume
 ok 9 name.0.63
 ok 10 write_default.0.63
 ok 11 write_valid.0.63
 ok 12 write_invalid.0.63
 ok 13 event_missing.0.63
 ok 14 event_spurious.0.63
 ok 15 get_value.0.62
 # 0.62 PCMD3180 i2c2 Dev3 Ch7 Digi Volume
 ok 16 name.0.62
 ok 17 write_default.0.62
 ok 18 write_valid.0.62
 ok 19 write_invalid.0.62
 ok 20 event_missing.0.62
 ok 21 event_spurious.0.62
 ok 22 get_value.0.61
 # 0.61 PCMD3180 i2c2 Dev3 Ch6 Digi Volume
 ok 23 name.0.61
 ok 24 write_default.0.61
 ok 25 write_valid.0.61
 ok 26 write_invalid.0.61
 ok 27 event_missing.0.61
 ok 28 event_spurious.0.61
 ok 29 get_value.0.60
 # 0.60 PCMD3180 i2c2 Dev3 Ch5 Digi Volume
 ok 30 name.0.60
 ok 31 write_default.0.60
 ok 32 write_valid.0.60
 ok 33 write_invalid.0.60
 ok 34 event_missing.0.60
 ok 35 event_spurious.0.60
 ok 36 get_value.0.59
 # 0.59 PCMD3180 i2c2 Dev3 Ch4 Digi Volume
 ok 37 name.0.59
 ok 38 write_default.0.59
 ok 39 write_valid.0.59
 ok 40 write_invalid.0.59
 ok 41 event_missing.0.59
 ok 42 event_spurious.0.59
 ok 43 get_value.0.58
 # 0.58 PCMD3180 i2c2 Dev3 Ch3 Digi Volume
 ok 44 name.0.58
 ok 45 write_default.0.58
 ok 46 write_valid.0.58
 ok 47 write_invalid.0.58
 ok 48 event_missing.0.58
 ok 49 event_spurious.0.58
 ok 50 get_value.0.57
 # 0.57 PCMD3180 i2c2 Dev3 Ch2 Digi Volume
 ok 51 name.0.57
 ok 52 write_default.0.57
 ok 53 write_valid.0.57
 ok 54 write_invalid.0.57
 ok 55 event_missing.0.57
 ok 56 event_spurious.0.57
 ok 57 get_value.0.56
 # 0.56 PCMD3180 i2c2 Dev3 Ch1 Digi Volume
 ok 58 name.0.56
 ok 59 write_default.0.56
 ok 60 write_valid.0.56
 ok 61 write_invalid.0.56
 ok 62 event_missing.0.56
 ok 63 event_spurious.0.56
 ok 64 get_value.0.55
 # 0.55 PCMD3180 i2c2 Dev3 Ch8 Fine Volume
 ok 65 name.0.55
 ok 66 write_default.0.55
 ok 67 write_valid.0.55
 ok 68 write_invalid.0.55
 ok 69 event_missing.0.55
 ok 70 event_spurious.0.55
 ok 71 get_value.0.54
 # 0.54 PCMD3180 i2c2 Dev3 Ch7 Fine Volume
 ok 72 name.0.54
 ok 73 write_default.0.54
 ok 74 write_valid.0.54
 ok 75 write_invalid.0.54
 ok 76 event_missing.0.54
 ok 77 event_spurious.0.54
 ok 78 get_value.0.53
 # 0.53 PCMD3180 i2c2 Dev3 Ch6 Fine Volume
 ok 79 name.0.53
 ok 80 write_default.0.53
 ok 81 write_valid.0.53
 ok 82 write_invalid.0.53
 ok 83 event_missing.0.53
 ok 84 event_spurious.0.53
 ok 85 get_value.0.52
 # 0.52 PCMD3180 i2c2 Dev3 Ch5 Fine Volume
 ok 86 name.0.52
 ok 87 write_default.0.52
 ok 88 write_valid.0.52
 ok 89 write_invalid.0.52
 ok 90 event_missing.0.52
 ok 91 event_spurious.0.52
 ok 92 get_value.0.51
 # 0.51 PCMD3180 i2c2 Dev3 Ch4 Fine Volume
 ok 93 name.0.51
 ok 94 write_default.0.51
 ok 95 write_valid.0.51
 ok 96 write_invalid.0.51
 ok 97 event_missing.0.51
 ok 98 event_spurious.0.51
 ok 99 get_value.0.50
 # 0.50 PCMD3180 i2c2 Dev3 Ch3 Fine Volume
 ok 100 name.0.50
 ok 101 write_default.0.50
 ok 102 write_valid.0.50
 ok 103 write_invalid.0.50
 ok 104 event_missing.0.50
 ok 105 event_spurious.0.50
 ok 106 get_value.0.49
 # 0.49 PCMD3180 i2c2 Dev3 Ch2 Fine Volume
 ok 107 name.0.49
 ok 108 write_default.0.49
 ok 109 write_valid.0.49
 ok 110 write_invalid.0.49
 ok 111 event_missing.0.49
 ok 112 event_spurious.0.49
 ok 113 get_value.0.48
 # 0.48 PCMD3180 i2c2 Dev3 Ch1 Fine Volume
 ok 114 name.0.48
 ok 115 write_default.0.48
 ok 116 write_valid.0.48
 ok 117 write_invalid.0.48
 ok 118 event_missing.0.48
 ok 119 event_spurious.0.48
 ok 120 get_value.0.47
 # 0.47 PCMD3180 i2c2 Dev2 Ch8 Digi Volume
 ok 121 name.0.47
 ok 122 write_default.0.47
 ok 123 write_valid.0.47
 ok 124 write_invalid.0.47
 ok 125 event_missing.0.47
 ok 126 event_spurious.0.47
 ok 127 get_value.0.46
 # 0.46 PCMD3180 i2c2 Dev2 Ch7 Digi Volume
 ok 128 name.0.46
 ok 129 write_default.0.46
 ok 130 write_valid.0.46
 ok 131 write_invalid.0.46
 ok 132 event_missing.0.46
 ok 133 event_spurious.0.46
 ok 134 get_value.0.45
 # 0.45 PCMD3180 i2c2 Dev2 Ch6 Digi Volume
 ok 135 name.0.45
 ok 136 write_default.0.45
 ok 137 write_valid.0.45
 ok 138 write_invalid.0.45
 ok 139 event_missing.0.45
 ok 140 event_spurious.0.45
 ok 141 get_value.0.44
 # 0.44 PCMD3180 i2c2 Dev2 Ch5 Digi Volume
 ok 142 name.0.44
 ok 143 write_default.0.44
 ok 144 write_valid.0.44
 ok 145 write_invalid.0.44
 ok 146 event_missing.0.44
 ok 147 event_spurious.0.44
 ok 148 get_value.0.43
 # 0.43 PCMD3180 i2c2 Dev2 Ch4 Digi Volume
 ok 149 name.0.43
 ok 150 write_default.0.43
 ok 151 write_valid.0.43
 ok 152 write_invalid.0.43
 ok 153 event_missing.0.43
 ok 154 event_spurious.0.43
 ok 155 get_value.0.42
 # 0.42 PCMD3180 i2c2 Dev2 Ch3 Digi Volume
 ok 156 name.0.42
 ok 157 write_default.0.42
 ok 158 write_valid.0.42
 ok 159 write_invalid.0.42
 ok 160 event_missing.0.42
 ok 161 event_spurious.0.42
 ok 162 get_value.0.41
 # 0.41 PCMD3180 i2c2 Dev2 Ch2 Digi Volume
 ok 163 name.0.41
 ok 164 write_default.0.41
 ok 165 write_valid.0.41
 ok 166 write_invalid.0.41
 ok 167 event_missing.0.41
 ok 168 event_spurious.0.41
 ok 169 get_value.0.40
 # 0.40 PCMD3180 i2c2 Dev2 Ch1 Digi Volume
 ok 170 name.0.40
 ok 171 write_default.0.40
 ok 172 write_valid.0.40
 ok 173 write_invalid.0.40
 ok 174 event_missing.0.40
 ok 175 event_spurious.0.40
 ok 176 get_value.0.39
 # 0.39 PCMD3180 i2c2 Dev2 Ch8 Fine Volume
 ok 177 name.0.39
 ok 178 write_default.0.39
 ok 179 write_valid.0.39
 ok 180 write_invalid.0.39
 ok 181 event_missing.0.39
 ok 182 event_spurious.0.39
 ok 183 get_value.0.38
 # 0.38 PCMD3180 i2c2 Dev2 Ch7 Fine Volume
 ok 184 name.0.38
 ok 185 write_default.0.38
 ok 186 write_valid.0.38
 ok 187 write_invalid.0.38
 ok 188 event_missing.0.38
 ok 189 event_spurious.0.38
 ok 190 get_value.0.37
 # 0.37 PCMD3180 i2c2 Dev2 Ch6 Fine Volume
 ok 191 name.0.37
 ok 192 write_default.0.37
 ok 193 write_valid.0.37
 ok 194 write_invalid.0.37
 ok 195 event_missing.0.37
 ok 196 event_spurious.0.37
 ok 197 get_value.0.36
 # 0.36 PCMD3180 i2c2 Dev2 Ch5 Fine Volume
 ok 198 name.0.36
 ok 199 write_default.0.36
 ok 200 write_valid.0.36
 ok 201 write_invalid.0.36
 ok 202 event_missing.0.36
 ok 203 event_spurious.0.36
 ok 204 get_value.0.35
 # 0.35 PCMD3180 i2c2 Dev2 Ch4 Fine Volume
 ok 205 name.0.35
 ok 206 write_default.0.35
 ok 207 write_valid.0.35
 ok 208 write_invalid.0.35
 ok 209 event_missing.0.35
 ok 210 event_spurious.0.35
 ok 211 get_value.0.34
 # 0.34 PCMD3180 i2c2 Dev2 Ch3 Fine Volume
 ok 212 name.0.34
 ok 213 write_default.0.34
 ok 214 write_valid.0.34
 ok 215 write_invalid.0.34
 ok 216 event_missing.0.34
 ok 217 event_spurious.0.34
 ok 218 get_value.0.33
 # 0.33 PCMD3180 i2c2 Dev2 Ch2 Fine Volume
 ok 219 name.0.33
 ok 220 write_default.0.33
 ok 221 write_valid.0.33
 ok 222 write_invalid.0.33
 ok 223 event_missing.0.33
 ok 224 event_spurious.0.33
 ok 225 get_value.0.32
 # 0.32 PCMD3180 i2c2 Dev2 Ch1 Fine Volume
 ok 226 name.0.32
 ok 227 write_default.0.32
 ok 228 write_valid.0.32
 ok 229 write_invalid.0.32
 ok 230 event_missing.0.32
 ok 231 event_spurious.0.32
 ok 232 get_value.0.31
 # 0.31 PCMD3180 i2c2 Dev1 Ch8 Digi Volume
 ok 233 name.0.31
 ok 234 write_default.0.31
 ok 235 write_valid.0.31
 ok 236 write_invalid.0.31
 ok 237 event_missing.0.31
 ok 238 event_spurious.0.31
 ok 239 get_value.0.30
 # 0.30 PCMD3180 i2c2 Dev1 Ch7 Digi Volume
 ok 240 name.0.30
 ok 241 write_default.0.30
 ok 242 write_valid.0.30
 ok 243 write_invalid.0.30
 ok 244 event_missing.0.30
 ok 245 event_spurious.0.30
 ok 246 get_value.0.29
 # 0.29 PCMD3180 i2c2 Dev1 Ch6 Digi Volume
 ok 247 name.0.29
 ok 248 write_default.0.29
 ok 249 write_valid.0.29
 ok 250 write_invalid.0.29
 ok 251 event_missing.0.29
 ok 252 event_spurious.0.29
 ok 253 get_value.0.28
 # 0.28 PCMD3180 i2c2 Dev1 Ch5 Digi Volume
 ok 254 name.0.28
 ok 255 write_default.0.28
 ok 256 write_valid.0.28
 ok 257 write_invalid.0.28
 ok 258 event_missing.0.28
 ok 259 event_spurious.0.28
 ok 260 get_value.0.27
 # 0.27 PCMD3180 i2c2 Dev1 Ch4 Digi Volume
 ok 261 name.0.27
 ok 262 write_default.0.27
 ok 263 write_valid.0.27
 ok 264 write_invalid.0.27
 ok 265 event_missing.0.27
 ok 266 event_spurious.0.27
 ok 267 get_value.0.26
 # 0.26 PCMD3180 i2c2 Dev1 Ch3 Digi Volume
 ok 268 name.0.26
 ok 269 write_default.0.26
 ok 270 write_valid.0.26
 ok 271 write_invalid.0.26
 ok 272 event_missing.0.26
 ok 273 event_spurious.0.26
 ok 274 get_value.0.25
 # 0.25 PCMD3180 i2c2 Dev1 Ch2 Digi Volume
 ok 275 name.0.25
 ok 276 write_default.0.25
 ok 277 write_valid.0.25
 ok 278 write_invalid.0.25
 ok 279 event_missing.0.25
 ok 280 event_spurious.0.25
 ok 281 get_value.0.24
 # 0.24 PCMD3180 i2c2 Dev1 Ch1 Digi Volume
 ok 282 name.0.24
 ok 283 write_default.0.24
 ok 284 write_valid.0.24
 ok 285 write_invalid.0.24
 ok 286 event_missing.0.24
 ok 287 event_spurious.0.24
 ok 288 get_value.0.23
 # 0.23 PCMD3180 i2c2 Dev1 Ch8 Fine Volume
 ok 289 name.0.23
 ok 290 write_default.0.23
 ok 291 write_valid.0.23
 ok 292 write_invalid.0.23
 ok 293 event_missing.0.23
 ok 294 event_spurious.0.23
 ok 295 get_value.0.22
 # 0.22 PCMD3180 i2c2 Dev1 Ch7 Fine Volume
 ok 296 name.0.22
 ok 297 write_default.0.22
 ok 298 write_valid.0.22
 ok 299 write_invalid.0.22
 ok 300 event_missing.0.22
 ok 301 event_spurious.0.22
 ok 302 get_value.0.21
 # 0.21 PCMD3180 i2c2 Dev1 Ch6 Fine Volume
 ok 303 name.0.21
 ok 304 write_default.0.21
 ok 305 write_valid.0.21
 ok 306 write_invalid.0.21
 ok 307 event_missing.0.21
 ok 308 event_spurious.0.21
 ok 309 get_value.0.20
 # 0.20 PCMD3180 i2c2 Dev1 Ch5 Fine Volume
 ok 310 name.0.20
 ok 311 write_default.0.20
 ok 312 write_valid.0.20
 ok 313 write_invalid.0.20
 ok 314 event_missing.0.20
 ok 315 event_spurious.0.20
 ok 316 get_value.0.19
 # 0.19 PCMD3180 i2c2 Dev1 Ch4 Fine Volume
 ok 317 name.0.19
 ok 318 write_default.0.19
 ok 319 write_valid.0.19
 ok 320 write_invalid.0.19
 ok 321 event_missing.0.19
 ok 322 event_spurious.0.19
 ok 323 get_value.0.18
 # 0.18 PCMD3180 i2c2 Dev1 Ch3 Fine Volume
 ok 324 name.0.18
 ok 325 write_default.0.18
 ok 326 write_valid.0.18
 ok 327 write_invalid.0.18
 ok 328 event_missing.0.18
 ok 329 event_spurious.0.18
 ok 330 get_value.0.17
 # 0.17 PCMD3180 i2c2 Dev1 Ch2 Fine Volume
 ok 331 name.0.17
 ok 332 write_default.0.17
 ok 333 write_valid.0.17
 ok 334 write_invalid.0.17
 ok 335 event_missing.0.17
 ok 336 event_spurious.0.17
 ok 337 get_value.0.16
 # 0.16 PCMD3180 i2c2 Dev1 Ch1 Fine Volume
 ok 338 name.0.16
 ok 339 write_default.0.16
 ok 340 write_valid.0.16
 ok 341 write_invalid.0.16
 ok 342 event_missing.0.16
 ok 343 event_spurious.0.16
 ok 344 get_value.0.15
 # 0.15 PCMD3180 i2c2 Dev0 Ch8 Digi Volume
 ok 345 name.0.15
 ok 346 write_default.0.15
 ok 347 write_valid.0.15
 ok 348 write_invalid.0.15
 ok 349 event_missing.0.15
 ok 350 event_spurious.0.15
 ok 351 get_value.0.14
 # 0.14 PCMD3180 i2c2 Dev0 Ch7 Digi Volume
 ok 352 name.0.14
 ok 353 write_default.0.14
 ok 354 write_valid.0.14
 ok 355 write_invalid.0.14
 ok 356 event_missing.0.14
 ok 357 event_spurious.0.14
 ok 358 get_value.0.13
 # 0.13 PCMD3180 i2c2 Dev0 Ch6 Digi Volume
 ok 359 name.0.13
 ok 360 write_default.0.13
 ok 361 write_valid.0.13
 ok 362 write_invalid.0.13
 ok 363 event_missing.0.13
 ok 364 event_spurious.0.13
 ok 365 get_value.0.12
 # 0.12 PCMD3180 i2c2 Dev0 Ch5 Digi Volume
 ok 366 name.0.12
 ok 367 write_default.0.12
 ok 368 write_valid.0.12
 ok 369 write_invalid.0.12
 ok 370 event_missing.0.12
 ok 371 event_spurious.0.12
 ok 372 get_value.0.11
 # 0.11 PCMD3180 i2c2 Dev0 Ch4 Digi Volume
 ok 373 name.0.11
 ok 374 write_default.0.11
 ok 375 write_valid.0.11
 ok 376 write_invalid.0.11
 ok 377 event_missing.0.11
 ok 378 event_spurious.0.11
 ok 379 get_value.0.10
 # 0.10 PCMD3180 i2c2 Dev0 Ch3 Digi Volume
 ok 380 name.0.10
 ok 381 write_default.0.10
 ok 382 write_valid.0.10
 ok 383 write_invalid.0.10
 ok 384 event_missing.0.10
 ok 385 event_spurious.0.10
 ok 386 get_value.0.9
 # 0.9 PCMD3180 i2c2 Dev0 Ch2 Digi Volume
 ok 387 name.0.9
 ok 388 write_default.0.9
 ok 389 write_valid.0.9
 ok 390 write_invalid.0.9
 ok 391 event_missing.0.9
 ok 392 event_spurious.0.9
 ok 393 get_value.0.8
 # 0.8 PCMD3180 i2c2 Dev0 Ch1 Digi Volume
 ok 394 name.0.8
 ok 395 write_default.0.8
 ok 396 write_valid.0.8
 ok 397 write_invalid.0.8
 ok 398 event_missing.0.8
 ok 399 event_spurious.0.8
 ok 400 get_value.0.7
 # 0.7 PCMD3180 i2c2 Dev0 Ch8 Fine Volume
 ok 401 name.0.7
 ok 402 write_default.0.7
 ok 403 write_valid.0.7
 ok 404 write_invalid.0.7
 ok 405 event_missing.0.7
 ok 406 event_spurious.0.7
 ok 407 get_value.0.6
 # 0.6 PCMD3180 i2c2 Dev0 Ch7 Fine Volume
 ok 408 name.0.6
 ok 409 write_default.0.6
 ok 410 write_valid.0.6
 ok 411 write_invalid.0.6
 ok 412 event_missing.0.6
 ok 413 event_spurious.0.6
 ok 414 get_value.0.5
 # 0.5 PCMD3180 i2c2 Dev0 Ch6 Fine Volume
 ok 415 name.0.5
 ok 416 write_default.0.5
 ok 417 write_valid.0.5
 ok 418 write_invalid.0.5
 ok 419 event_missing.0.5
 ok 420 event_spurious.0.5
 ok 421 get_value.0.4
 # 0.4 PCMD3180 i2c2 Dev0 Ch5 Fine Volume
 ok 422 name.0.4
 ok 423 write_default.0.4
 ok 424 write_valid.0.4
 ok 425 write_invalid.0.4
 ok 426 event_missing.0.4
 ok 427 event_spurious.0.4
 ok 428 get_value.0.3
 # 0.3 PCMD3180 i2c2 Dev0 Ch4 Fine Volume
 ok 429 name.0.3
 ok 430 write_default.0.3
 ok 431 write_valid.0.3
 ok 432 write_invalid.0.3
 ok 433 event_missing.0.3
 ok 434 event_spurious.0.3
 ok 435 get_value.0.2
 # 0.2 PCMD3180 i2c2 Dev0 Ch3 Fine Volume
 ok 436 name.0.2
 ok 437 write_default.0.2
 ok 438 write_valid.0.2
 ok 439 write_invalid.0.2
 ok 440 event_missing.0.2
 ok 441 event_spurious.0.2
 ok 442 get_value.0.1
 # 0.1 PCMD3180 i2c2 Dev0 Ch2 Fine Volume
 ok 443 name.0.1
 ok 444 write_default.0.1
 ok 445 write_valid.0.1
 ok 446 write_invalid.0.1
 ok 447 event_missing.0.1
 ok 448 event_spurious.0.1
 ok 449 get_value.0.0
 # 0.0 PCMD3180 i2c2 Dev0 Ch1 Fine Volume
 ok 450 name.0.0
 ok 451 write_default.0.0
 ok 452 write_valid.0.0
 ok 453 write_invalid.0.0
 ok 454 event_missing.0.0
 ok 455 event_spurious.0.0
 # Totals: pass:455 fail:0 xfail:0 xpass:0 skip:0 error:0
 root@am335x-evm:/bin#

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Shenghao Ding (4):
  ASoc: PCM6240: Create PCM6240 Family driver code
  ASoc: PCM6240: Create header file for PCM6240 Family driver code
  ASoc: PCM6240: Add compile item for PCM6240 Family driver
  ASoc: dt-bindings: PCM6240: Add initial DT binding

 .../devicetree/bindings/sound/ti,pcm6240.yaml |  177 ++
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/pcm6240.c                    | 2217 +++++++++++++++++
 sound/soc/codecs/pcm6240.h                    |  252 ++
 5 files changed, 2658 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
 create mode 100644 sound/soc/codecs/pcm6240.c
 create mode 100644 sound/soc/codecs/pcm6240.h

-- 
2.35.7


