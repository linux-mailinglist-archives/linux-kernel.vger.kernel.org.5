Return-Path: <linux-kernel+bounces-102683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9458187B5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427B42832AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5014A0F;
	Thu, 14 Mar 2024 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ui20HWCb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B27FD;
	Thu, 14 Mar 2024 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377628; cv=fail; b=AdUearciz1Fsh87M13JllsZ26A3VIM8E6CNwcso0YTbi4hKwT7PRq/4wbuoGJki2iPEawMXEyjLV63qczjV/2Q1FzWb/ELKgH+DnnpzOKGQf/jooTAQeZh4DdxmwjoixOxjJnfiXQWhG1Cno/6J5nSjMFeQZX6Bbbf0/JZ3pXWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377628; c=relaxed/simple;
	bh=EzRJnPTJYG7HiqEqc8wKXhjvZ3vCuP+dACFUCdmqUN4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=jCFp9+0uZue38Z8cwgDACOYoD1HtrmqtDfpBfCxLWeitnKxOl6rY9M91FyldN0jTKbOaIerM8+G7Af5gvrCl2Atr+THNUTUkwsnn60u+qux+Y+UDxYLTvJV1EqUJRobQPIFYwQpJ+SiqB+nfmDejWi+9P14aBeDPJZfjLTQA5n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ui20HWCb; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTzMWMt1CO3K9pKN2nGmzMoKPab/lUFcIAfv+ll+FGk39hP3jr3TQU+S1J854flNXk6hZm2nrQCw/5Z7vl9SBXNrNGC/W6qFz8yHB7HSkntEcZt82YMFonBhnHxFdLTB5NNgjxV5bYjdtodaBwRZuJQdSHFPQFZrvJpga2IZVCxd8a9MKwMqXm/HBaLY64ky/vVaBNcz3TqTxPsQJnvqzurTiJ+1G7UBK2HQb5flTtRvxacSs6Hbaxk6b0i8DOlB+xcyQrIPaCdLscjD/EU5dZYXXxuiS7hUAj60aKnoK53uvS/5jrt8ojAXI6WnV95XFKS+qgjd5D/aaMDoqm2//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4xCe3GKgsIqP63D4+wIEA5U7ntLSPBFDvAflvBpuM4=;
 b=NdhJBHVgT+DQrviMsu2Pnlg1ikniWSvZEXifIX91geA/stob0rqWmivyaVFcQ4s6oIWC0OXap0MYX7smK/B3kBTcaxlmt6VFyfH3+lTzw4i1atJbfPApQ88Nsw+TwynmTsE8n/X14h3mo3aUcu2qZm7xhniF9bZR0nwaCIuz4CN4u33yte6+9cF7MOtsaToErAjvH3NhT4VaA+6/deha9YGZLC9ildkXFUSCglP2Vzz3jfprlsVKNq3FVgCEwDWWtX6HmRJ1HIQO3/VDNAWtYlBiRMSQvzfYPI0XnBA/IuqjkRHPlQhpQyKNzSwyAndB44ppoEPjcoEaS0OyIBhcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4xCe3GKgsIqP63D4+wIEA5U7ntLSPBFDvAflvBpuM4=;
 b=Ui20HWCb1Njk0Q8qNfwlYNQtkepaWzQPa8/hqigEa6ZHVky7hXuvFKRavx2WKSljnZpha54f/7cYndWXyJZxaUUvDrtJroKKyf729I9OFAbOdta/FThaW+tNQCgh528U0xOWinzdcJaTQSNH+6sVLhnKB/ucgNgcSpv+FShC+R8cQdj1OKfI7eOA9dqpS9HJ+u7daO172a0kIR5GHazH9UYLAEmPXsnsROXUkE/VYTtDmmSVbzwqr5UDxFP64fn3P8rZyKNhmeyDizCqtLqQ5jmhlb73ctKs0FczJVSeHSSOdDd3Qu0skduWijvqHwzIlGxkaupP1ruche6VPHALuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 00:53:44 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 00:53:43 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-2-rrameshbabu@nvidia.com>
 <20240312165346.14ec1941@kernel.org> <87le6lbqsa.fsf@nvidia.com>
 <20240313174107.68ca4ff1@kernel.org>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Date: Wed, 13 Mar 2024 17:50:39 -0700
In-reply-to: <20240313174107.68ca4ff1@kernel.org>
Message-ID: <87h6h9bpm1.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e64e081-3cf3-43da-337c-08dc43c1326c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OPoh3GpDBFDYszdBq/xoqHbmZM42GTKYqenrPxklV1QV1hhiFnvWQYwKj+YvLER3+go0zbtcNwwz+Z+gAu21cA2qI2kLC/RVCL7qYBUeFLTJzO8hCbbqKeM8mYIzRt8h5ZaHeDr22A08Q43NWFzcBB9wJWr5pSqpbzOTtNfuq/F6MTN0paYzdoPDKidwYacno/hOXYvZwNqP4sHa8q1lHebRWTwBdyCJSLI6820qRroxv4RAGNjN1X8VaoaUkzfMHdlRdCbAHCh0cCOmYuPDfLu0lNSxkJwp3mZ1vEfRYq9Sbn7paAkm/IHMc4gzzzlQmbsR2sDuz6mDysjSuULMZp9+Fm+bMXUfbht+FtfGIs0eXsLlxDY5TmIdgnguzKEygygTNeBOm2ySvWKSev3J/v/b0fKvrqVGzA1czMrZPwzxuFJ/OpyNKVDP6gQrpwChdNoPw6jHS7U0mribeEuodVGrFZlbL+eeYx0RweZVyq56Vm9xSWrT7FxGojuWkJ2HJrYi/w+wg/DsWxAMa8MSZx+tIy9Zi2ncJuxq+mpVApvXadem2YbDPqQA2kY+fL/KLj02AYwrMcI5s7R+y4ZBg5Wckp7Ubw7kipUh/fl4/6TMA5MFEYxOtFMdz3tI3V204wVv2OIEaN9YPKXuATiYORRRhSUFpp/1aZnoi0tPJps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eo61tvK2Zmtq6pVkeVeV5p/T7tN9q+3NhK4jmQoC0ZqK8aY24r7WwJrxEYi5?=
 =?us-ascii?Q?wEsGVJqEUHUfA8eb6NW5dF2mFrmZ2yetAPGmoGKe2WMP5gn81BAtoQrk44AL?=
 =?us-ascii?Q?pomwElONdtRrK5mU8xwyrAI4PouWZ9LzykC0Ox0c80byXNAjZU9prtJD3QRR?=
 =?us-ascii?Q?EO/JOOXwfaF7/wevinvTCoOb4qvi12CI1eG/dAl7Z1eEXdzcTV1JsRPGK+GO?=
 =?us-ascii?Q?w1l7QHijMKjpR05SB/RCvXHfhH8Y4HNLgmcmt2SuXQmqMLh84P7c3hgsEfZK?=
 =?us-ascii?Q?oJZ5mb9wbIlEdKxSGD2trbQ1ABm1ivkI+KYTbsAWzQMmDpzQW6o5EFCq+28s?=
 =?us-ascii?Q?7okbdvt7wQ6TkgtCmQ1SPek/JcdiK4YVX9zm5ruSv237u1Dd/Xo6a/NayhTx?=
 =?us-ascii?Q?yOcyK2sXHoA55KedvYmP66a1Whw02y/DMDME8ACjOeqJ3/sZ0M40npsyjHgs?=
 =?us-ascii?Q?iMTSQc9Eczk0Xt2S53Yp69brrNLRAvFf9ElF8AvVoVDA6ILAHZ0/EX8Ldh8R?=
 =?us-ascii?Q?Hv+fTQ8Ixv+S2uN/svF7iOmLbteaiqy5cELEyAy7OMF4swzgDKF1IhKaeD2Z?=
 =?us-ascii?Q?66NbEM0Rf3D7uD4g4FGfKIBrbRkdSllBqPD2PHvoksQ1kGLJR6kM8qs/5NHv?=
 =?us-ascii?Q?hxBv8d0yhaePbX+nJtUxnc59ksXT3N5zY/qM7GWR9amr7kzXlKcsrRgAAecH?=
 =?us-ascii?Q?SqPhO+p4b7iPjmQz0C33NYwgYJAHxo6v7N+lqJpoA/m0tzA0DLoMbjHXJMa5?=
 =?us-ascii?Q?XNsqUejPRGv+VVEUCfS7oaAFJnFcaOGRsLBBwftI23CT9oyclaTMFhBxldM2?=
 =?us-ascii?Q?RxqdadGZ3CjO/NMyKH0cQZctHXIjW2utsQA/5rIWeDMKp9Nea23sM10tKSE4?=
 =?us-ascii?Q?4Xp57QLXHlj4fbxkoEtJ1ECJHkclqSb2AduJtiHuICIMBjvIg0f2bAnC74M1?=
 =?us-ascii?Q?1RbR+sGpealkQDkadPGGMGQ+L6vP/J/Y3C+d2DcpG5EaIFj2av+NoFNOvUjs?=
 =?us-ascii?Q?VVj18/pKv/kXyqJSfIjWt9MYxo00CVVpY6atkrVqU/05XxmYIen1Gr75aCnJ?=
 =?us-ascii?Q?y+JJ0YrpyC1WSrBgEY7a6q2XZ+vGXWZkq0SSRaIlQPgEs23arRFgyTx93Q/h?=
 =?us-ascii?Q?ORw9FAGRAifiLXw3YHCmmUl6OkwibKSjNn0jeRBhlVhGVKZ7OCjZfh8q1ryq?=
 =?us-ascii?Q?Ao22Yw+yq6etZaqYT7GSWyTsSwkkvHLOYkMeM1+FaT48GIISBFxSy8gVVxFY?=
 =?us-ascii?Q?NJX93uTo/dyXa/LhCiWKtWG+lBmdw7ALeLJPUB1A6hkSyEvhzRQDaRu7qYeD?=
 =?us-ascii?Q?uQN0nYXAUpV0gqkRn7KHN0fV79ynFZIAfiGJjvl3JtwyUbgogtku6DgDcxvJ?=
 =?us-ascii?Q?1pRsWodpoJPXy686dXKqeRlZski51qikqpk53bDg9ohCO05MiuINJK9C8G4N?=
 =?us-ascii?Q?nFx32e5eroPOdE5WE3ATyM6NGfRM1bLiqe03FBr1l7UYKvRxqilxM4NPS7WH?=
 =?us-ascii?Q?ceVRat8iOYrRYICoM64/cPrEHzDl1ydr5U/8bJ4vlSPVfhSi5qdzpC6eKLM6?=
 =?us-ascii?Q?cRyoztl5L4Y+kLU+xHBU6NccOhDdhI4p+u2j3EKAQPidZ+rSF3hZAFcPkOfH?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e64e081-3cf3-43da-337c-08dc43c1326c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 00:53:43.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEcZuc2IwCILjTYEPQJkeCqH3GqKidU/9BZK4Ezo7MBEAwy/cLOaqzVP8KuCO3ddZ3wMjrIZ04bqa7NyddJk5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001


On Wed, 13 Mar, 2024 17:41:07 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 13 Mar 2024 17:26:11 -0700 Rahul Rameshbabu wrote:
>> Makes sense given that these are stale and should have been changed
>> between my v1 and v2. Here is my new attempt at this.
>> 
>>  /**
>>   * struct ethtool_ts_stats - HW timestamping statistics
>>   * @tx_stats: struct group for TX HW timestamping
>>   *	@pkts: Number of packets successfully timestamped by the hardware.
>>   *	@lost: Number of hardware timestamping requests where the timestamping
>>   *            information from the hardware never arrived for submission with
>>   *            the skb.
>
> Should we give some guidance to drivers which "ignore" time stamping
> requests if they used up all the "slots"? Even if just temporary until
> they are fixed? Maybe we can add after all the fields something like:
>
>   For drivers which ignore further timestamping requests when there are
>   too many in flight, the ignored requests are currently not counted by
>   any of the statistics.

I was actually thinking it would be better to merge them into the error
counter temporarily. Reason being is that in the case Intel notices that
their slots are full, they just drop traffic from my understanding
today. If the error counters increment in that situation, it helps with
the debug to a degree. EBUSY is an error in general.

>
> Adjust as needed, I basing this on the vague memory that this was 
> the conclusion in the last discussion :)
>
>>   *	@err: Number of arbitrary timestamp generation error events that the
>>   *           hardware encountered.
>>   */
>
> Just to be crystal clear let's also call out that @lost is not included
> in @err.

Ack.

--
Thanks,

Rahul Rameshbabu

