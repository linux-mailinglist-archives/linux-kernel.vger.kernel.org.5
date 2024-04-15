Return-Path: <linux-kernel+bounces-144738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A938A4A08
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B281C214A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D13D0C5;
	Mon, 15 Apr 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="OWfCMWIu"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2092.outbound.protection.outlook.com [40.107.7.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBB3A1B9;
	Mon, 15 Apr 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168808; cv=fail; b=tdluTn/qr7PZbQKny3N36Kcfk9QPuSgWqUYdH0pPM0Ei14IEGCFAfcil1SF3wcqbnhOwiAMh1yaYJOAU/uKbw9uYsdLYXN/KWul+7v+02wa7q3oGkkkrtk6213GwI50uhWP+rIKXMOCMZf6WEv34ky6GiJEHyyYHc2bWLnNErJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168808; c=relaxed/simple;
	bh=DbMIqFE48QPZGX3tHgZgmG8nnZPoAJxlzjCAIhzJTMg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=IJw0R0gKMAFYjr4Dk9h4LtcAzPXzoRFy8H/JgN/z2FKk9P2J9JG99u2o6lisvWUGeGDVTXm9iN6SafuwvUolPR8LgWfMcSwno42g1QTuFWdXZMp0ftzLseDq2smoAGBBtATP7dfWbmMjjpxqUZTDYexaPz20whH4oMbPVKY2Tqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=OWfCMWIu; arc=fail smtp.client-ip=40.107.7.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkbUX6AkYpM5E5TZOzYqT1IpcfSB9jmJXfAbO2P7aWc4jwt+fmIo3kdRwonrjhG/6Wr2MS8gif0YXIwZCz788wCZWlzCWerOiynQhrqVbArC5y5QuNEsTBVvXmGD50zCn7XUZmh/DTJk6YCh6e5tpjV+y15z0tDmDUkN5FiB0gKx3O5ImUUWpHjDPtVrp7sNVGoqJADw8arIvFM0sqFU1e0Fb0GWHiS7UnyZPwNxbMFRrpowbZuBqcYhFwms/6m1vKF8vnCNCHSExm8clIiEeumn3DNyTp3NAWrGhzxICBXzlqkLK/5sEPwyjJuFql1NT3QGiKUroteW1lU80hD09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM0GYnb+LCQZA1SJ1xN8BGBtGWYPC+YBaACg2JyuFQ0=;
 b=Z2HNFaD9a2xNH6b5c9kxYe899L294wF3HxikXVCSDz15txxujOZ7sNlT7Mn6pxFWQ/6EZ+d7rYThdJmSxaR66+ilmKBJQB8Wj3h4fKsm3rZ1dDlxsQadIxhfou9BR+Q35vZ/zzCJfRRZ6E7/eb9iJqHlTbSEU1CaNY4O0AbocBdQTlf92vB+SPxHNTanShppKzbEqeu3DFHQyzYSQcmskLeaEJvheaOPtzyd8X1UKb9YbnODFGlMdyGMJzNQl3V/T1AO+NH2wTWPr4+5nwiwsWbB27eKzPkqPvFHpyO8nqfulc6JqCbLWsb0KA06SeJMdwo2nCuMdQmkdJFiuTc71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM0GYnb+LCQZA1SJ1xN8BGBtGWYPC+YBaACg2JyuFQ0=;
 b=OWfCMWIueOTT6lh3XgB8s/atz7oWfvYLn0pzv1SprfaSb+2Zr13h+RVdt117GJVnLQVtzAa53r+H2Ris4XaGnTDWh8iW8vQZOgRFjH1fErwAJkqtpQ5fc6XYm2tRVRwKzOyZwB9pl8vtXQowoAAcuzH3FEF1Qqb+nniGiEZZYndWB4y50YOzUjoBqbJmbPF3ron3nKKTHQlbt0DaFiG1j8YUpwyKjhpPkAcZrjQXcBgINt4C5j/Nvz4z3pook7OC2tKA+GKntO9MMIANa1NF5hjFuRKNItvTp13HpWwKDZsywaQ+DDoqHfv1OVP9t3TwjaWdA+C5M+2VRsdJl0YZRA==
Received: from DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) by GV1PR04MB9104.eurprd04.prod.outlook.com
 (2603:10a6:150:23::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:20 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::cb) by DUZPR01CA0125.outlook.office365.com
 (2603:10a6:10:4bc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 08:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 08:13:19 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.105) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 Apr 2024 08:13:18 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 08:13:11 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 08:13:11 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pm@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: power: Extend battery chemistry with capacitor
Date: Mon, 15 Apr 2024 10:13:01 +0200
Message-ID: <20240415081305.316107-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PAXPR04MB8288:EE_|DB1PEPF000509F9:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 093ec577-1ecc-42b2-e17a-08dc5d23e956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 JjvqCUAfQxbire0ax6yh17rykGCfsTOBxPHpNyw9zsrlhUCd1Ky87QfZlT8xn0OH4kO1S/gny2A2FXeBZpbLPFiSp3HjcaiwqGiHH3oLKhCZwloSPV+WGaR2VjcF8AadOghEzg7FyI6UkAlJFgzB8ItxZzU5MymRpwV58/15szHm8qyfhXcYiKjS1cgFKYOjp/8X+m+LrvUqS9qAT12vW/8i25FTZgRDo12/jZ7kDd4NUumg1FbV/OpWn/aq+mHVVlpa/hSKAShUiB4/RQrMzQUpQPaPwjqNck/a6aLqk++upB22rxENo4EuTIefR373SfH4Nm6agMPWnff/+dQ+HhOvLwT4I0vyDuz3LFsiCFlPnaIQlRX37mabKMg98Ni2sQN1UMx67P9j6ps1QT15+SDUIWrQvAH2K9qeg7jyjJnuY2I+U/Oo8TWyTcETjpdN2LzHl083VWr/eWqprG3pQlFcmK+U4hc8PftB5Iz6qbfrRH6KHi8QKk64a9VyVaZxCa9acoGc5wmdIF50Z7Hfu4e8NwsIHFDQEYVkepaL48hJuA6l+PBsnA2iP0Dmxh9sHbmMmmKnz/5TTof+krAww56aG5P7W3kqkVXOkpzER5BjBdepe72Zmn+6wNqfvsmXVv4suIy7ZYcoDAECaUVbZorSP2ya1jfAvTj/k//2WW/aRYpB9YQG5LDWZvqdbHfMwKVCgzi43T9fKu01sJuHtQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-CodeTwo-MessageID: ba7e6d2d-244b-4915-8e65-acf77f724428.20240415081318@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b2a893bc-f00b-47cf-ae07-b37ec1bace22@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	67619643-946b-44ba-6543-08dc5d23e43e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	muR3G+MVkVROzNaUI624cBzPCyIHr2vskS79EMNfRnhiv9JOpeXRHP9YAWypRxOrBGMV5Md8HTs0qQt012YEl/YsnV7peaS0tDR/sNl2gdTyF8UJF8uWvpDTanPJBZkGQ55sUp6I0oQrLXQTYwe0MRC/x3eC1ZfFqG9pObCBLQHXAaK3KjhGkWjzCtJkopYxdR09QRvrn2vbvvUc1zHKEo1Z7LPyZUtVPWTteZQmSHT1CNyosklsOpAyXU7CfPAL4rVh16TR6r1gAvYjRcouwTkS6x9xI4f+vdqBJ2n95YmsOE+dlXeOZvfyOaIRvEJ+nCwdOQeDQEcawQoiFrdJ0ItY2gLrgU+SljEmXQeiD/Cao3hEhbFdu4/2Htxmbmnc/B3UyVHwPOVTmDX2iAeeQVIVVpzsHWsiHMIgkAUmbAo4qOEtoEg/MCXZFHEY2cwbk6VypCJpVC4t3nVWJRStr63Ul8s+snDz9Ga1o2+jZj4/9nhB/DGDzJwenl/l3I7YdYlLttSNhfdj0pF05OhFgEiGqkheBaPdRJhPj4x4TyvUg3Zj2/KnIwaH+j1IIHIbnufb8zw24bMa8QpsCIBToYwMyGbQtfffi9/RgHOhYHS4staQO3QNCqhw9ihUUr/qa0pqMOgiCwy5Rfs701kTSMyqa9rWNR5i6Uk+7iO4RCq/lOofR18sfX/2cDSbLLZ/Yi1gY35GSXIsufRUnj49Vg==
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 08:13:19.9635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093ec577-1ecc-42b2-e17a-08dc5d23e956
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

Another technology to store energy is a (super)capacitor.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

(no changes since v1)

 Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/=
Documentation/devicetree/bindings/power/supply/battery.yaml
index 491488e7b970..a22c97dfad88 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -44,6 +44,7 @@ properties:
       - const: lithium-ion-polymer
       - const: lithium-ion-iron-phosphate
       - const: lithium-ion-manganese-oxide
+      - const: capacitor
=20
   over-voltage-threshold-microvolt:
     description: battery over-voltage limit
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

