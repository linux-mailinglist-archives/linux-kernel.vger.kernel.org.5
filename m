Return-Path: <linux-kernel+bounces-467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06A81419B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA77E28440A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F237470;
	Fri, 15 Dec 2023 05:55:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4479ED;
	Fri, 15 Dec 2023 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id F0E7124E233;
	Fri, 15 Dec 2023 13:55:10 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Dec
 2023 13:55:10 +0800
Received: from [192.168.125.107] (113.72.145.168) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Dec
 2023 13:55:09 +0800
Message-ID: <e6059181-a1bb-438b-8490-108c64316171@starfivetech.com>
Date: Fri, 15 Dec 2023 13:55:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] media: v4l2-ctrls: Add user controls for StarFive
 JH7110 ISP
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	"Marvin Lin" <milkfafa@gmail.com>, Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>, "Ming Qian" <ming.qian@nxp.com>, Nicolas
 Dufresne <nicolas.dufresne@collabora.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Tomi Valkeinen
	<tomi.valkeinen+renesas@ideasonboard.com>, Mingjia Zhang
	<mingjia.zhang@mediatek.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Jack Zhu <jack.zhu@starfivetech.com>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-staging@lists.linux.dev>
References: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
 <20231214065027.28564-2-changhuang.liang@starfivetech.com>
 <20231214113955.GK12450@pendragon.ideasonboard.com>
From: Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20231214113955.GK12450@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Hi Laurent

Thanks for your comments.

On 2023/12/14 19:39, Laurent Pinchart wrote:
> Hi Changhuang,
>=20
> Thank you for the patch.
>=20
> On Wed, Dec 13, 2023 at 10:50:19PM -0800, Changhuang Liang wrote:
>> Add a control base for StarFive JH7110 ISP driver controls, and reserv=
e
>> 32 controls=EF=BC=8Calso add some controls for StarFive JH7110 ISP.
>=20
> ISP parameters should be passed through parameters buffers, not V4L2
> control. See for instance the V4L2_META_FMT_RK_ISP1_PARAMS format in th=
e
> mainline kernel, it describes how to store ISP parameters in a buffer.
> The rkisp1 driver is an example of how this can be implemented.
>=20

That means I need to add a video output device before ISP subdev? And=20
use queue/dequeue buffer to get the ISP paremeters?

> Please note that the ISP parameters need to be documented precisely,
> regardless of how they're passed by userspace to the kernel. Even with
> V4L2 controls, documentation would be needed. Please see below for
> additional comments.
>=20

I will add annotations for this file next version.

>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> ---
>>  MAINTAINERS                        |   1 +
>>  include/uapi/linux/jh7110-isp.h    | 342 ++++++++++++++++++++++++++++=
+
>>  include/uapi/linux/v4l2-controls.h |   6 +
[...]

