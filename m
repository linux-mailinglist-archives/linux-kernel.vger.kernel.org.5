Return-Path: <linux-kernel+bounces-72837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14F85B932
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C91FB21301
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36262160;
	Tue, 20 Feb 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E75SlKCN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2050.outbound.protection.outlook.com [40.92.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AB56B74;
	Tue, 20 Feb 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425469; cv=fail; b=kKrQUMpg9FGmv4uuu1Mo9knyoNsNIbrDBjI1ZsuxSmdhKGSdoP3zswD6qjdsq5251I23T6BghQ4/+GGoWwTm5K1F7EDF7IihaXJrFEI/7HjBcU2x3PNNWXP1tfr7THeepHHkAqbZZP2IV/Eg70fHxQ24Jqa0oNS+SiJrM2KiIHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425469; c=relaxed/simple;
	bh=J1pORw1JCa8hslU9XhFDXmfBDIPGXNgljEZmzz+G45o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDDswpKowzys/SqiP6ljFTCgBrk1FaXB/Sox/Na0x7HLjePIy6DmrDqSuWc2AumKMnRvBWqsgd6N26n7fhsqphMy/kyI5HqmpIztfMSj5sHOCjU0bU8MFyZkcMvQZPiFmCi9s7dx2154RzuX/8d5wM/7jpCI3Ok5aJFqpTsR9uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E75SlKCN; arc=fail smtp.client-ip=40.92.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ/U/eYTyDaSIPZV1fJFRo/SpMR/yzFSmsl+kOcnM2UCayuvWL/4NT/u2Z0Ok8vRc3+Hrafg8zv4nrE1S2K89munJkB/DkVxH6XpwsarlmyEAEQsSllQ/4fAyYoD8chk+7lzcvLzuuU+7Mn3QU9JluhDGncsUZ7Vs9OvqMtFNcVNGaXxVFAq/9YG99GfduZiL0af02GNEWzYaD60P8equQ5UrAsK4UYP39XP1XgdndcTJcFhre5Md6rGgzguCtsFNtUAA5tPQ0wKqy8clw+weYBRHAKIHq0lEmF5xvpudas3G7oVOhtCOts1JgK0GmL+QYZxADqiVLukt0I8DOLeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozfeCGrMIvSLhD1zxY2abDFbFsquiiJZaW7aUzdK1G0=;
 b=FlcguNY0ayBi7MBsC8tfua9+zlQILRzYlJXs6+DWN4bMB2+JEJ0mCX15dKvcFmXv71NAuxtV8r+7kXG9lUIyqNhC75vtha1OnyHgt9ku+qvtQM4XGgf1GDLxbe5B5RLyQJjP93Ytm/q+3PQgpHbuK4NmC+sk5jonKPW5+iyaugClfRrGQnedGGMgtxJbU/E/KWYnyJVa7y16CyquYvw5bp+8J0GvLgrlfd2mREdrycNEdLZtnqypqXffd85s8h5CGenYaDssqS3ZGtu/lTSO1njEqjknZiF5nicKQ8ihAx+D493uEBLg+zeYy6iHlWXLaRkcWVnTomNgNixuCp7MDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozfeCGrMIvSLhD1zxY2abDFbFsquiiJZaW7aUzdK1G0=;
 b=E75SlKCN9x1L202ajg7u1uBA7t4U5xmNyeXE/HCW6wXdyPHFDa8Lyn6YFBRzXAeRPrG6tGGr4Ln08eQGBSX6UVDjvyh/FM1n3PzN6MfA3xkLxLriiWyaeK9vXGnryTAGKGU+alW5EE2Tm+x37dUlH7uQ5CNYaVfv99bEhmbgXy24/iZHQuAb2WPERhTpEau9uPrm65Y9ywPFiEa9BkA2ZE7jgRGC0marbsoZGch0ewWdaP9LgFh7rCTyaUR7CVs0vabRwjMnr+/rT3jImtzdvpdg5wYkonzNVDoQQ9KKWg9rnd1U+0rCI5OBbZIYNDp4dJZLoY5liSGCpJPmOpEd7g==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by BL1PR20MB4588.namprd20.prod.outlook.com (2603:10b6:208:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:37:45 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:37:45 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: Add top misc controller of CV18XX/SG200X series SoC
Date: Tue, 20 Feb 2024 18:37:36 +0800
Message-ID:
 <PH7PR20MB4962ADC17704683D90B8BE13BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <99df43cc-37fd-4f50-a086-2864a6545673@linaro.org>
References: <99df43cc-37fd-4f50-a086-2864a6545673@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7QRY85gDSne2eOonHJ/KvkIIqLXY5+z5EvZINbRf6nI=]
X-ClientProxiedBy: KL1PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::13) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220103737.882017-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|BL1PR20MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 234d5a0e-b576-497f-dfbd-08dc31fff92f
X-MS-Exchange-SLBlob-MailProps:
	O8uo9vZ0QHU57nZ+bmZTlwNTf5+IW0LuC9iPUZYaWsHeSP++fhOBBc3yKcwAgmf1ivcP0GXzo58GlXsUen18DN4ssnfCU+sSE4x5QbFDyBT7cNoVZf8Ze6yKrNFGRfP48Ai4wJd04HpYIwGu+zU/b2NTdF6zlOsm/0YxnaWPT2n/2PUEjA7EycRqKbCMv0dUM+AEETb086bWYpkuCpQxhANrZbAzL36m+WPCetupWPOyzJNEjaA6tvJBSwKSuhH55DmhdiOFxFAhxxQGzKQp7b1ogvQGVeXWX0/e5vKIQsoScUpL7y2F4Sp3vK8Gspc3giXgPpmEk8RD7RStMgsNjy8602aRYsQVUEuTzH+VSqkRg2QRmiJMpgGwkDH3NgrGsivuaEG281SGYLGhm1gjhEBenqrDStEzrBKxoAlbSLbc4ReBYN2BMKRFtauBwHmI98dxJyDA1cudFmdWmAuZi4YysEeilooYYPaJBZRsmXctW+3cakQDfnCutzJbU6x+YvBLLMMf8si8ibat4lt1Rb0CmVoJFFbQoQm5Aomm8VyOrJDrch1MMWz/orx0HHdnRBwHdSq94lLPc4MDfoNZaSGQnI2qLKEZq+HELiSpDHKzEOdrKo09gCBn6KXmLvqAL83ql0VFVOi9zqpF8DpHwz7h9e6VDS2tHkQkF2RRxLHlGYyGPZT78o4XMG90t6jwTOnFVCkUx31be0oUspSTw/AeeWjarlqgktyZA5FsM0HuKyjSr7Tp/9z/F4I+yhCR7JxA3phzcuvx2TNZXmsYv4VWuck7ye85bhl2eR6W4CkKahXu/mITz2wVSODmjeopjdrQbgaWI+GFhMt5BFKV0aw9iZ4083aFHgh9ofdLAFQOPcT62RPTW3EG7yQyItZ7RZXPdrxSKtHbzBc8YWq2gw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kqzZ6xaUwxo+zPKT3BsbugFwLLv2l6kI+4QfqbtDLudb8IZaXst6M5BT+n6zNmrKhUYKPqrXBBnKDMs3iwmEn2uuvCqr28HYHUmsIowTkTjiaKDrccesBHtBYQDbZVlERd9aRksBWmyRtGm3XyC8mtuK/C+gHGktvl5AE0JB/lvK0vxSaOIDQRTkYiYOQT6i9JfhEIV6OYrlxrOl15bns0vszbmcJ2B9cPJyaQ/h9j8KFo5qZ9vSarwkUMbGDHL8c+ZtyfS6i9JQtzNlGC1LilzKqjtoIJy69vA17fJvzuIW4cJDsQ/Gci3xikTG+9Yw438Pb5nG2ZyrnA6PtSQPI+nDRw1Kz7DV/B1e/KMw7feYk16xJ1mgjen2/+z0iRycS9ECIjv+HCqB0HXNVlEDu8BDo9fKIxqdZpRNBF/VPCYCazATiM/eFX5t1jq+9kAL7vR3t1a2gyH7pSkWHVbxqKtThvTUPOMQVvARcO4C9goabQEFTSS491ejZi+jqmXJykedYpgeU7fFEIP7xAuuBPtUOHALKAyEDjo/G61u3YNF7pOMio1PBauqUdWxx047AEA9AKAZswjJrGEphyrTmOliImy40cf9bHz2xEpzw1Jxg6IOsK4hTXKWsQIJ06xJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8tTfnqpj3S/60MS2ulNXouMjaWgJfXTgVfxSv26doO0iASgVvp8EA2zYvwO/?=
 =?us-ascii?Q?/goGY0o4nDiDZ0TsmwiUk0opiyL8MBL2EXXt3V5mzREpI9sk9giA8qk54Y/N?=
 =?us-ascii?Q?HJWEBLFZ9r4dyGIeW2FlnO+wlvTDXc8Ut/3U0O0PIFcJ3V5XA4Ok69uTBghr?=
 =?us-ascii?Q?4/NOLzmA/UEZlOu4a+0hWunpxMBFg5lrBmrJE83RRFP7fX6mUETthuTVs7Ow?=
 =?us-ascii?Q?E4EEoU4/1VfrT0fclNqfZAQiTA3NYIn6YK29P+o2Zb1Qd8hgkgaP0humzImf?=
 =?us-ascii?Q?t6wj1y1w5Le8PoiM9CzS7TKcbpLqnLDIAZshJ/oZVmUEiMk6AVakQ1slQ++X?=
 =?us-ascii?Q?VzFDB7JV2CbnHsnuZgrcVYe/vAHdK8sjC4q4vQUaGdVuEKsJBUIt5opqjz6o?=
 =?us-ascii?Q?Fj2Ff2MexbXmW6uyhISBVXZ7LVQ5Yv6pJQMyL1rdJHgFOY0nRvPx9+w65ktS?=
 =?us-ascii?Q?JZLOaJmfDIJm4950r9bDK16kee95+Ofe7QZDzBjkI9D5F0+tIdvqAVcvgaDH?=
 =?us-ascii?Q?4SSF8B7Vts1vN8o7g1nqyIF4dIFcrlNm/rfSSiKQKPw/gim2WoTlVsAKWKsX?=
 =?us-ascii?Q?Yq57Hr2WakGWgVfQ8vsT0mvcHOxTSrhOHxmIAnpW1m1EocVOhNxRUWNFCWPW?=
 =?us-ascii?Q?YAUMh0pJh1I/EjfaXyhlQCVyh+JLFEXP2M3UAY7P5vagR2tiOPIqPhb+3rcd?=
 =?us-ascii?Q?hpiAqNWRPafCMwWGB/CDrFPOn6DoaHejeenJjhVyfMMrvemIpAMxUr+b46TG?=
 =?us-ascii?Q?eb70BC0iMSOjILn11KnXESfgbtJon9z1udgWiy8jIeyBQIu8sttTC8xV++vG?=
 =?us-ascii?Q?t35GuCs7qelGlMEAZjEBSwb1DgfqXwd/Z8v1FkTNzPYOnD+fHVWfQa0OQh/X?=
 =?us-ascii?Q?qMwvOAX7cU0sDSeHc4uKSgUKL0FCDlHQ/InpXEgbLFgX3YcokLlC0wmwOMQT?=
 =?us-ascii?Q?phR+ki4AuPQ0oh62aKQjgdIovN25Mo+63QEh++ujeG6Gy+Kp/38tkj/+GAaW?=
 =?us-ascii?Q?5kgBN/o/+0jPIoNytHf0ASJ+agR8gHJ6lWfkVtaMLbua8fPXY1Acn0zON8sy?=
 =?us-ascii?Q?5oh0RPdd5xfeDGOeC7uFk6fE/abO7f5vxa1gDMXC3QW7fdI1yz+vg/uHDh2s?=
 =?us-ascii?Q?5fi1Lm9RmPUwnKZbN9cytsnH0Gp3k4jSRtb7ODClmzOF9MTMPxg5OhUcPQ/A?=
 =?us-ascii?Q?mzeChkag/0kxHeMxqpaskrRiegMgKRLvtKSlU7EuqAyigF//HCHn0JEwOCQG?=
 =?us-ascii?Q?LNYDrN/0Dn0zlNFSLedZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234d5a0e-b576-497f-dfbd-08dc31fff92f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:37:44.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR20MB4588

>On 16/02/2024 00:56, Inochi Amaoto wrote:
>>> On Wed, Feb 14, 2024 at 02:33:14PM +0800, Inochi Amaoto wrote:
>>>> CV18XX/SG200X series SoCs have a special top misc system controller,
>>>> which provides register access for several devices. In addition to
>>>> register access, this system controller also contains some subdevices
>>>> (such as dmamux).
>>>>
>>>> Add bindings for top misc controller of CV18XX/SG200X series SoC.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>> ---
>>>>  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 40 +++++++++++++++++++
>>>>  1 file changed, 40 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
>>>> new file mode 100644
>>>> index 000000000000..619237532801
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
>>>> @@ -0,0 +1,40 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Sophgo CV1800/SG2000 SoC top system controller
>>>> +
>>>> +maintainers:
>>>> +  - Inochi Amaoto <inochiama@outlook.com>
>>>> +
>>>> +description:
>>>> +  The Sophgo CV1800/SG2000 SoC top misc system controller provides
>>>> +  register access to configure related modules.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - const: sophgo,cv1800-top-syscon
>>>> +      - const: syscon
>>>> +      - const: simple-mfd
>>>
>>> You have to define child nodes to be a simple-mfd.
>>>
>>> You could drop it, but I now suspect your binding is incomplete.
>>>
>>> Rob
>>
>> Hi Rob,
>>
>> I have a small questions: Can I drop "simple-mfd" and just add it
>> when the new subdevice is added? I know the binding is just a example,
>
>No, because bindings should be complete.
>
>
>Best regards,
>Krzysztof
>

Thanks. And please see
https://lore.kernel.org/linux-kernel/PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com/T/#t.
This new patch series includes this binding.

