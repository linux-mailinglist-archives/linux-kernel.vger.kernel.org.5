Return-Path: <linux-kernel+bounces-163538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE0A8B6CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137A4283E42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381EA128830;
	Tue, 30 Apr 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X3QC69mm"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2017.outbound.protection.outlook.com [40.92.40.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906167E58F;
	Tue, 30 Apr 2024 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465645; cv=fail; b=aGH9srRwNge0T2CGN49Wlgsqu4d9R6C11igE6pvNnr54zGYgYVpk9F42EQN/EPwow3DRMTF3tQHDL8uHoot2ZeUA16MLRh6jWNxVxYxR7aKZc9fdP5Jgz3qXAnvh0x/euJkaq21gALdqvpAJjIaQ1NX7vl59Jg2YwNdptfm5YRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465645; c=relaxed/simple;
	bh=SRjCzd+sFVb+g6YEaxNLFIxpM+I/1lRtbgtfkbA+ROc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rHhKQtA95UhPMArKqVyJViCH8vHkx3V907BrJ4+RRIH9Po5Wppjje68VGLW/0dqVyPGC5yN5fZmR3JSnGst0WfV6o5pJp5Tjv9HkOccyT9e5gIM9h/XAA5dMb6XKMN58UuSvPwFzhbhnxLem9+WKZeTKkK/o2tVGTVlSrzVYcrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X3QC69mm; arc=fail smtp.client-ip=40.92.40.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebk4CU5OvfuTdRPYX4pNilpCKhh1p3Yj+ap8SIPh5eScubFEaJWTNGJzWWy7egL97JrKEAvFuME7BHpaRpsxELQzk9GxdjoNBWKKiANPPG7lofdszUQalaXWfnuuD9bulXGORf/bVAmRGyULUQMNYIXkdGfj3N5i+i6DIvuneyXzTqAac0hDcYTOzIO8b/HODe8Q61H9HwgjIL2Xun7t5QxYBUje5iYEsPTrMbhLrFIoYozlYawcT/VNh4dRRiKtXGMOqTQeuo9LxBFABzQSlUyveo0dMw6SqzmknXAL/LFnivZG7tqK+DXsN2WHD13mFAXl0dyWvrqkvUkY/GIX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRargXPFGNgl7+HOrI2kiaQqFVGWbMb2E6uqYzaCTHA=;
 b=dlRik9V4LjgIvhU1iK8Peh4lXIi+HhYb39n/AsYM1vvT/DYhBspM2c4xTlQ3CmD4ghro9KMi+F9W/UVqvOlPjVY92uv2gfy80t1A94FnL/0Cj6NqgqJfi/IEokW85g3Ug7kbcDQLO7uewtBDjDhWnOZpckhrucLLkoTbA0B+U32aoawK3lxkmkzCWtEzI2C1B4XZ0JAJdlL/utGmtDBttFZAfiqICoxArD31Dh99DuotGQw/Gg/XACZwjufHJC9TQ6ontGAKC9Tii7fiCHytSaFvu6uucfG0w4SXTHP45lOU5TIjE1oyNaNFEAcKZI0Yn7aG1wTS9U11/0rpYm85+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRargXPFGNgl7+HOrI2kiaQqFVGWbMb2E6uqYzaCTHA=;
 b=X3QC69mmQbA66YfI3P2xIHgbvcDSWwUDLqOpiZbzAiwT/t5EqQjIyDud+zCVWOWwLGnYxNnCnwBSFvpb8sNPfIHIZqobMbvTeogtk9Z0Hj2poJSdQ+FYBCIVM6nhofKIAK81QSsC4XeQNfc4t1cObXVZYGfzIS6Ju2I5+sdI9iwIDQhpqjB+wQu+0wvsxZxWlUCbFf5B3OToR1BMh4OLcvoUW2154xO6EvUJqYiDcwu7RD7I5g6BDXU9PjQz7oIqGLVGFaxLJY7MDJOoSWfvH5AJCimWKp3yQVSSCDZHCcnCYdxRVBsK7dM1qHUt8UPgbjGNaAdHNuP8PxRsrhiTag==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7367.namprd20.prod.outlook.com (2603:10b6:208:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 08:27:21 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:27:21 +0000
Date: Tue, 30 Apr 2024 16:27:48 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB4953F13D16B99FC04EB2AD30BB1A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953D1C509CC7F23620CCA01BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EF54DBF6D5681C27014BBB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <97886e14-f07f-4175-8e8d-2d70c2daa907@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97886e14-f07f-4175-8e8d-2d70c2daa907@kernel.org>
X-TMN: [3viKnHrMKAg5OhgmhPqM+9pHCm7swcwECXfhsBngu9s=]
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <c5an6lflwhridboemxdq5mq3gosaqdbjczorbkyeloq5vulzfz@prcm3gex3nzf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 16434118-d337-42dd-e508-08dc68ef5ac8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	fjC0taqLhqttUkXaQZnfBhv0QMVPN8k/VKFYc646TXBqIEyBSUcjAllqUyfTbqzGwNLMWy6SdszgVGnuyEsw4g5V5JtXhWlAC5emk7P/oWDnWL6IsHm2vTuSxXvUmn68RS5WZRW+NulFE4zkxLx8J2YgQPWTQZZRVuo9U8CNCNmRjdWyBNDWl02OR5IS/E2v973hVUgFd4X+cChlSLBA6Gc1l0Ageq0uU5faNE3BW+Ou9CFeGWZ+LuDqxhyntinL5EiDbtf4k9UG9j8uYkGWcRKhNCDidRnapyi2+9TyTsu4y7sIGxfs0l46W39SsRN4fDC8mF9W+50gW3EBFxNsuTWdtENYK+Fcxpj97Y+thhaaB3fWq0eX+CYJsTwsVuHjmNKCpYERYxCr9Udl7fDO9dXzZeYVycaKKmPBUMIsFFhkrnsn2Xv7xR23l+HUkFcLMMgC2oi1hJ3iEDwTHBPZWE/FBaxvZUhzuY1qpwpXu/GEyB4i8t7MlGY5Sei3AlZO5ObmXgj/XhPUgip6DwlT1opz/CsboypSFvO+59VxSakrW5Vg9cA8b3IyJe+N0zQf8RhC86zNpkqrHDsg4qWYm/1+XvNrK9cE3PvqalMIZuY1uXi3t8lUsDnEAtUedNGESDrO8GbvOqbDEw3nDWoMsL1cxOh8rBzPxz/4VW8zAxA608q/r/fKTJeh00mTOrMQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UNZ2Xai7HSDd9sbuhw5i8u6e3knNneBuyywP3jDCVNFrj2sqh4EwT8EXJNGa?=
 =?us-ascii?Q?89jSW/gRwu+B7eOS/q2wEXIpeyytGYL/sOmrHR9vJMku9O4x5KIaz8uvbSQ1?=
 =?us-ascii?Q?ATvitCNQgLLeXzWD6PSuGrd1bj89k6coF5YKVwXVWPrKT8BcmYEd54cavwyJ?=
 =?us-ascii?Q?ufgAwRThZHP4oKIUczIwACH0ScWnr34QeBxHbjI2Su8c/1nQ0FbCiMuZBKKo?=
 =?us-ascii?Q?Jnb54pc6XQ00yHQSvbYTcTWWaFKSENGYXexw3BP3Vv0git6gfmU4xQtpXG0t?=
 =?us-ascii?Q?Z4Ekf1b+fZiJ4jffovDUITYwbXogOtiL7jjowN6ka0D8Z8OEKVQ+Xw9twGUQ?=
 =?us-ascii?Q?BcUmoe/oxwb7bHgvp2uTqHGcjBQvPkCIc7Hwq+7/os9H2LVRHub2LUKsy4sB?=
 =?us-ascii?Q?WyDqVqdVCwKg3rFJCqIFZQ7OWCSWvB/KpdFND/eYhsK0pqA0lRPOSIPnwOnt?=
 =?us-ascii?Q?m8qtdYbShxQMSATAUT+qbVfHboOpMTav5E1Svy6f+kApgF/WKl6yuqh7E9Ou?=
 =?us-ascii?Q?iVDeZdtUhjCOX0ZfhTFbvnkjDEQ1nxV+OsElDV4XXSVxqf9Q75+brdyzUx+Z?=
 =?us-ascii?Q?cM0s0PLOz5izNOxnXFmx7fC68uc16hi8kCb/eKzieKHcKRtOZPGflbyNNCIU?=
 =?us-ascii?Q?iRC5snVlDz5x9YCZ0KahRK/FnxRCtGAx9DW+iAtXa1E6cIuUpT1R7U0xw8/I?=
 =?us-ascii?Q?IaDKMOuY0E9jgeVqmACKT7J+7/cWD/Cf77/SYLmWxELh4wbWrqYM410C1D4O?=
 =?us-ascii?Q?GW0BzmLX4ndzm1xakzYFpDbBHUGbIpmCyrRrMQ6nw7bO9vytL8j9gRRBe6hT?=
 =?us-ascii?Q?tRP2sCx51yq6pbmAtSa8RAl15+/5+7AihdONIKsionRRB7v4DRF9yt1xyKaK?=
 =?us-ascii?Q?eutgB7ffjU/rM5QbX9UvdUiK22K3XUB1iwpd2Pj//1jF1TK5KtwW7MNBaWvy?=
 =?us-ascii?Q?gizJ8wHQK5ls8OwL5PIUQ+qZolAaTtEF28ikZhdm0SOCsrvyk3lAvWNIROdR?=
 =?us-ascii?Q?hXHXS//2Y6KSHONFfv1clw8nNXzqNz0InHZcoyHX1Bijbs/W7KG+bWhQCISv?=
 =?us-ascii?Q?Rx1h/uOrKIY74Xidohv3zp/DS9KEz7sIlKLUlrE+HFwxrTJOImEc31MrgN9r?=
 =?us-ascii?Q?kB+yXCzmYH3Ja69KwOux9nHwjIUCkUnpmnp241BgyYk0numM1lgSFQAJ/2so?=
 =?us-ascii?Q?oKc+qgwP5m+GHXOGqi7K80Wk/eRGvr62eoPsl9VxDd+SCYF+465+pjcWtw0J?=
 =?us-ascii?Q?+V4KxvXdL9NTLFNlXeTJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16434118-d337-42dd-e508-08dc68ef5ac8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:27:21.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7367

On Tue, Apr 30, 2024 at 09:47:16AM GMT, Krzysztof Kozlowski wrote:
> On 29/04/2024 14:03, Inochi Amaoto wrote:
> > Due to the design, Sophgo SG2042 use an external MCU to provide
> > hardware information, thermal information and reset control.
> > 
> > Add bindings for this monitor device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > new file mode 100644
> > index 000000000000..64a8403aaab8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo SG2042 onboard MCU support
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,sg2042-hwmon-mcu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 1
> 
> This looks like thermal sensor, so you miss ref to thermal-sensor.yaml
> in top-level. Just like other sensors.
> 

Thanks.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#thermal-sensor-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        syscon@17 {
> 
> Are you sure this is syscon? 

My fault, I forgot to change the node type after moving.
I will replace this type with suitable one.

> Title says mcu, compatible says hwmon...

SG2042 use an external MCU to provide hwmon info (on the
motherboard, not in the SoC).
This is why I say this is MCU, and compatible says hwmon.

> 
> 
> Best regards,
> Krzysztof
> 



