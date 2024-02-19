Return-Path: <linux-kernel+bounces-70903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54658859DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794261C2209F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA420DF5;
	Mon, 19 Feb 2024 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="oW8uuOmm"
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2097.outbound.protection.outlook.com [40.107.127.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195720DC3;
	Mon, 19 Feb 2024 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329640; cv=fail; b=uOX7oBRldFlqKLYFr3S+R44fUuKSALVdMdgleYOLvD2G1ZNzjX9rkkR7vNHFpJYl+nQNL89zAl2OzuuwfEtgi3Nu+eFrgDmujwlljNA740Trw3vlu9XBki+hEhJs2U363bbLTtYgY6knXIHh5CqUrW6eZbid8c0uhxyXSHe75kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329640; c=relaxed/simple;
	bh=c7vj/v878oowSjFhlrMex+oGv9IbveMNcMP5kXoKZ28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i0HuoTgS3hrTrJYzlq4x6b98RDOqt+KSQ2Hz23GU/ItU/Zx8UP0rh3I/0mrRdLLOUqOj/35jKAV75UNYqIFsGxgvCAPmv9SJg84PG/Y5n3OL0WBcZ8Th49JgUzaZeE0LDw+zEwoXiPDUTFhy+Clbhi+e/L9bjvhxKAHuTmCk2uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=oW8uuOmm; arc=fail smtp.client-ip=40.107.127.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlZ87VV6ZZz9q+F/lK6h2vMpGqkKoquqa00Ho5d4LS2dUivthdqUtPuGGRqVAFCGfGir8czHBlW8Ni+qMSoWNWx0XpY1il4DixD1MQlhAOd/26DrpYOYuMo7lDKVj/BqYNq9/m64fC1uBXVGxlicfmXekpO2iQegyNnqA2Bj1lSBvPhqjYjGGXOBRSF/V6T8ck3guv38WfmphW6qpUBcK6lFPbLw8OitXI8brMWLw2tp5Zo0Yt6KUThdJZ+nNEb81v/UwslVie4t7Xm+dAkMSupZ0vzfLAR4AMEbgzK9zMdwqJkMzZ72XeZsjpP0ypio55Y5HGjP3PfPn1EvbbJW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAxf8+fmmbpIhpHF9hKKwd6CfE3Yl1vi6AMloabTQvs=;
 b=bORr3+myBo2wmwr8Iy7BAJDKzTn2vo9KHz0jznfYXqo6iugAzkJfkIQmNBSBPkcP1ykP8/zPtcPZkdELqU7j7F/Byh7701nrukyKMCyBGD93JPA911K6X9bfDQ5kkFOvmIAMIcVQXhVjtl+yaIOHfgscqx2YKpRQxzURyVSc3q/mYoe0t0I8HY+AYlpsDgI5Zm/Am5cz3Ykm0ngf4hkzk31T6qd9aCFZpsBS5sZb7EyyjcleULyjCLwvijxNaVcgmhoq+KDFD/iqbmw0Rdx1D7SPjMP69GLIwiGGEusDHyp1L7Vf8mthqCTAzcrJHdO3hCtZIoX7sX8Xa/KLpqsmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAxf8+fmmbpIhpHF9hKKwd6CfE3Yl1vi6AMloabTQvs=;
 b=oW8uuOmmaWljAsi73nqeHF/1XL9JQZVv0RBV7xrIAzFtGZ+TuxWFIImN0oINTYm4SesY6DMJ8+sfmdHoLNPd+TzfKs/3IZm9SOjiBUN2GmlOBOsHlESfQqdzsqTdNNIWwli/+P/nLuYfmZRLujR7XkYz+Wv24aQh5eodPiLO6mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FR2P281MB2379.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 08:00:35 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a175:dc81:cb6b:2dd8]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a175:dc81:cb6b:2dd8%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 08:00:34 +0000
Date: Mon, 19 Feb 2024 09:00:33 +0100
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, lakshmi.sowjanya.d@intel.com, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: dwc: drop redundant error check
Message-ID: <arjrsej4vylprpevarvzufj5fp77hy7m4cotjubc7ufteegqxu@b5btt5aqjz65>
References: <20240219033835.11369-1-raag.jadav@intel.com>
 <20240219033835.11369-3-raag.jadav@intel.com>
 <m57yqdldszy3s44p5rdxd6kwii5tqzqa44aaevpe7bep2yyeuo@wls3ad3gcl7y>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m57yqdldszy3s44p5rdxd6kwii5tqzqa44aaevpe7bep2yyeuo@wls3ad3gcl7y>
X-ClientProxiedBy: FR4P281CA0414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::7) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FR2P281MB2379:EE_
X-MS-Office365-Filtering-Correlation-Id: 9923abdf-7227-48cd-09ba-08dc3120d9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	13WjN4RQbX5evAnPtodcHT4k3ApRs9JYXBHuqD/W9RWOwIPzHQ/foCAOOmrR5exTVL6YxqEEyucp1SSnnI8FIEUgRzVVOWf8ZGGuxNxkr/2aZE7GEqPQlbF6EHOH0igcpjVPP6Kbwxu12i0UGYrSCk/uahalvYP7dsj27vD0Y0BOwzmJyok6Hfh2/L0b3NmNf93MLXiVoN4h+llh4yTC4+jPV9vEYGaup7YhOT8q1E/90HtpsR2l3kw4WDtrFFSfTzqOqEFugzC+jjflqi1n1Y7C5/W7uHcZ0vaTkQk8+APDb0Kg6cHpsWpjAjyVbN9R0t9VpDrUr/m2VQhhok7E3Slu9Bz0Bm94Z1Q+4wMz2etpGks5OPREvwLQ0TED41WCqzHBEP/RYNnacnPWZhHmcVWFZGVNhKFwwRGJoUgxY9xiPi8oA5cCvJxbQayphpox9jBfk3G5uCgE1zwgaHfJHUr4tlYlyrjS9huHPgjh57auiWBVpTV7BcYt2LSBS/gkLRlFKCOYscCM0tpZOD7EQOlptYtR/c/c1dzHUG83N0d4ZZ7/HQmeYxd6a6bL+0fS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(366004)(376002)(39830400003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(66556008)(66946007)(66476007)(8676002)(8936002)(4326008)(33716001)(5660300002)(6916009)(86362001)(9686003)(41300700001)(83380400001)(6486002)(6512007)(6506007)(478600001)(38100700002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vCJxgJA6LyAifvVZFjXuIpf2XIatoIPt2ge9emoPnPA1LxxrJ75Zfzwqh7kV?=
 =?us-ascii?Q?036AGLGmOFCVwrO0wy2jf7kBW4yQZYXz+oiYQWQdX5sRYw4G38lfBip4cL8Z?=
 =?us-ascii?Q?svsafA7CWn8aJu/c+jfiS/zZhU6qbz+kbhWbAxDOywbQuRl6zydxrCL1lBdO?=
 =?us-ascii?Q?CPW+udwYxIc+TbhWmqybJBfe9WZ3VT+HjF6m+7oHmFO3xIiLh9svw0+ceWPm?=
 =?us-ascii?Q?+mZ3OF34gALxp8ZREBK/NmYYLjpXjwR0Ht/o4a/2/stWRqzC7dCTwAZO/u+N?=
 =?us-ascii?Q?bW3AmBtDC9O6TocmfvWbyqy/YbDtvs7XXrJa/UOnhMX7ppNk76zB1gTrAOWU?=
 =?us-ascii?Q?Tb1axOL+279qiO0is86PHLSZHnOK6TyQQjqvRhPmMzTd+3vdNU2kMLGN11Hf?=
 =?us-ascii?Q?C6pToWjqCmSfZ/pnLD0PFs5SQ6dK3OLR8PczklQbCsIG9ifiIoCkDE9Hf7Ki?=
 =?us-ascii?Q?umfDAOLBp5BBPqq1WYo0ob7zHaIyhx6WkDF3bQyujoxJjeYDbqBtr7Opnl9o?=
 =?us-ascii?Q?h1et5wCtoWry3noS9bVwHE7j8twg/u5RPeMEsCKIWSRuGMXJqpotTkGcswI6?=
 =?us-ascii?Q?nJIhyV9NTfE4YgbJP2jfxO4hx0eJEU4TmELS3izz4O+t1bmN23/yy0AH7Vjo?=
 =?us-ascii?Q?uI7KPT5M64c+x4fLaloscqe/8ves2teKXQP2yMj4bbPfMF4yT9fdgADfTVP7?=
 =?us-ascii?Q?LRF3GNcJX6obR2TfxSMN+vY8nvgoF58Sd4vvSab1jIws0isLscVrRe2vbxAI?=
 =?us-ascii?Q?UYd43SNlCnBgVu4og6cwGir95hFS5azDJ5E1+aY77RMnT+W5CdMKUK1mVqM4?=
 =?us-ascii?Q?Rq9GANW1HmRg4rsQm6E5KWaSZdnmKAkrSrzOnBBPfz9RrhJTgfqD7u/TkWfW?=
 =?us-ascii?Q?k+1LYTzfBrPjZVbNzQE0V1+DQx2z0uxBNYoWhHz4qvSh83pR6W5NnfB7BDAP?=
 =?us-ascii?Q?8QOV77Uo/TVx7LU6oNj5voQHqxspg4rx21yJEftuaLcUfSpfJk0OR9sW2Rg4?=
 =?us-ascii?Q?Bjh4ZQEB+aEer70taZzqis03zqNzip3G8mJjUHBVclV5nfzEJ6fGa+wJNVLI?=
 =?us-ascii?Q?hm9rF/+agZSka6atLAwDWjMbfO4Jay7Tc3TfzTB8rXPyCuSstrCJzOX+uOZJ?=
 =?us-ascii?Q?oA/RzzOjhVKgjtDwRMWrdLYEz/u/uplrj4rpkg+eaLIqijkeDNOxQNcyKug6?=
 =?us-ascii?Q?OqlmJ+/j3NGJHUG2NUJTBCFyn70WbrKmGILRQU0DJI+tgMoSGGkTB23royC8?=
 =?us-ascii?Q?/v8Mrrzl0XJe+ojc1Cq2wDLUhLOYwzZn78NWWSbc6C/OuTp/zQELw1ZmQ3YX?=
 =?us-ascii?Q?TCeDkCg0fjFHcZ+KWcQ/p5CnQ3Tj36urj+T1OfoeyTJWz9+p5HkHK/o5Ww6Y?=
 =?us-ascii?Q?hppcFVfUmnf69cgPP5Rt78Ar+mb58Pb3qaMdDHT3CmmD9cy7DoaWKDlALVEw?=
 =?us-ascii?Q?eESLARVxKxeigH8R1JWy7om6C7MlypW0qIYW7RgSn2IEUEf3gATXBlT09MpW?=
 =?us-ascii?Q?YF+NsE4VD8hq4lYzL3UV28ZuzgN6/1cNBp4TYL/9Isg89SOf2/LdTrqfWN7B?=
 =?us-ascii?Q?2RZGHrq4Tr8WLovFH/BUgHI8ZblHaUiNatwKqJU4DIaMQ+G7CILSerS1122G?=
 =?us-ascii?Q?Lj8HFU21IdIvnnIRdGS0LkMieSAGxYdsX6GQNA055yrXTSS1OauIghUvOfFh?=
 =?us-ascii?Q?yoN7WA=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9923abdf-7227-48cd-09ba-08dc3120d9cf
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 08:00:34.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQt+9tcK9DZoC2ZHj9yY/xKD4sF/Z8xgXcuRArBO0Xw7ayTaILwQ+oe75K7R6BER3LArVnwNrtFFhSpdTIXsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2379

Hello,

On Mon, Feb 19, 2024 at 08:11:01AM +0100, Thorsten Scherer wrote:
> Hello,
> 
> On Mon, Feb 19, 2024 at 09:08:33AM +0530, Raag Jadav wrote:
> > pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> > check for failure if the latter is already successful.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > ---
> >  drivers/pwm/pwm-dwc.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> > index c0e586688e57..7dbb72c80ef5 100644
> > --- a/drivers/pwm/pwm-dwc.c
> > +++ b/drivers/pwm/pwm-dwc.c
> > @@ -51,11 +51,8 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
> >  		return ret;
> >  	}
> >  
> > +	/* No need to check for failure, pcim_iomap_regions() does it for us. */
> 
> IMHO this comment could be omitted.

I somehow overlooked the discussion in the v2.  Please ignore my
previous mail.

> >  	dwc->base = pcim_iomap_table(pci)[0];
> > -	if (!dwc->base) {
> > -		dev_err(dev, "Base address missing\n");
> > -		return -ENOMEM;
> > -	}
> >  
> >  	ret = devm_pwmchip_add(dev, chip);
> >  	if (ret)
> > -- 
> > 2.35.3
> > 
> > 
> 
> Best regards
> Thorsten

Best regards
Thorsten

