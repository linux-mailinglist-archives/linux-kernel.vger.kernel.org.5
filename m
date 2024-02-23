Return-Path: <linux-kernel+bounces-79277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04B4861FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB644284D04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA74F604D0;
	Fri, 23 Feb 2024 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBEV+Rt1"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745F3D6C;
	Fri, 23 Feb 2024 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728133; cv=fail; b=rmv/PzS2ZMDZavgNLKdJMO/Ml6R0k+seEM7wPdy/QT5NzKbylhhUR/oGPemfy9LiBGS3UmPLLi7ZUZ/cUJw2ZeAq+ldIjUJdcocYxc10mAQtY+87qSYtpHUnEz/TAYc0pCjaggcTYAKeHQTylN77TExpAcVXxO4qYKSvMK/7rGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728133; c=relaxed/simple;
	bh=gYthuSO+gjabyP0W+NTh+yhcZjesqY4QObU5H3VH4ns=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=NqJEB3KaFx/lY29qaySr9kvoRaWOhzOKoyFUfdGEU3Tz6dBCS7s1M19dsKJvZGE4TOOA/7SrG05YkCoPA+QorCTm6HEbWPLAkigAKaTyABLF1U1y+MUKTlxjU3e0LV199op+s95fqXo60jPub18UR1eiDKIWWMH20MpxfnM/VPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cBEV+Rt1; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmD+ymQBNDD+z1s50tplsT528chnZz4OseyB1oBmhL+NLIROWxJU3u6QE/P4n+phOgEVKLwQXiqFMZ24EPgDzBsSi0PVC/vggDVFeHiLmL5knUL3GVHR0oJfOoBdlR21v8MeROO1D9Hikc+unM3pW/VI2DqKW82Cy1lkGSTL1sihpUSbw4MlUHv8EIdd3u5wJGPJqlyALWmgilCQm9rgQFDSompAFUvFbmfwbUgP3JafMo1kBf1JNqnirO4p319yHpLfvt1d1H4ZXm3UmtrL53JZV0GFeR9YrhZny+G9xLS+YlQAhtfPyYgZ8wGsvcH4eMiCvSxanwNmG9TCCQ1F+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/Atow9ZHyedikTQcpANYUjM9E5prjHylIXWIHEGs5A=;
 b=YaC9R3ybQq5FGB3EVOkpm5bm+8uvMQfwAPaGtYupAvW5Sygh0yTP/gQ6Z0s78eOAjJAHgsrFRuzMW56ORb+lNjAyfq5+g5yVYYWws7RQn+c4/u59sOesuVICRkGiddDOfI3yO9oUEBSQWXkWzSRRSAsaDGGNX6EZO0fkTuwAslP8qVMXd8R3ncNasB3BnKBK4rSLNSxHQOUBeUB8ozo/IG+T35z32YtEdOM/oxRs8sGEmuHbwMCs3upYuySmVhTuEDgqAF7f9ykGKNgBZd3GtlJ6TtCYh1Z9nNAwOHU7VZHCRedD2iGYBhiLm55Y+IsOLJ/HTCZa405sYLxmHyyAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/Atow9ZHyedikTQcpANYUjM9E5prjHylIXWIHEGs5A=;
 b=cBEV+Rt134Av+Ds+Vm3JUbpBhyGhDr9sotI5KzMHuFUrPqoNKZoSdCB4vgfkY8ATcU1MxuuV6oIUnZ7dfJc0h35eLyZkI5tPOw8/WO/hLuuVtisj+rv6bV0FRLO2wkoO+Jhz52eBF9KqPfxQ5od4JYjcu9kb1gkK3W3+XIZx5tcYvFB3XcOdBjIlZs/yeNff7NC91u/gvt4udo2PnlRuw+iaP9j4jvEUGyLmW0mpCzaFsvzgXjg5LfeNnSmzsUE3KXSlyPkMzT2Nku+in/+XjPXAuEjFc2yyYvHhWJs6MzlrDtDp9HrHmMOJD/pmIOrZQMb89vUPBWKs3IyStYJKcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Fri, 23 Feb 2024 22:41:49 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:41:49 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-6-rrameshbabu@nvidia.com>
 <6e0a725f-3bd8-4e14-afda-860f1e4c1dc5@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
 <richardcochran@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Ahmed  Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Paul  Greenwalt <paul.greenwalt@intel.com>, Justin
 Stitt <justinstitt@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Dragos  Tatulea <dtatulea@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net-next v1 5/6] tools: ynl: ethtool.py: Make tool
 invokable from any CWD
Date: Fri, 23 Feb 2024 14:39:07 -0800
In-reply-to: <6e0a725f-3bd8-4e14-afda-860f1e4c1dc5@intel.com>
Message-ID: <87y1bavm50.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 124c3f4d-259e-4e04-8907-08dc34c09f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lKMESuvTzENIbWRlf5/Au9qT8YtN4A9B2v8usu7Agyu+VFhlwb4hfREMtO2f0l1VMCRTRIgshR7gWmr2oUIWM51OIvncfto6svaZVLpsoDbggwlROWU1CAKLXA1Xp0toX9wF/ocsHJ9bDvn+jqj00dtftPU/JEdnf5P4OWTzOcp4H6wfz/RGpr574t/ivb91uM5900UHuG8pPeCm4uH3oqtz/cVj0RNGqDeUA41Ar2ueO3U5ij5IOZbm01HhRx0RjtD4opjrgTCWRujvhPCKUOJXhQq2RNc8w2WkVfM/2u9ksP35hye3M4bdFEiYJhCNh4RFQPO/0QGxX0e/D7aILSKN99Ih42s8QSuK3y0Hb3wJyMgL4Png2FFYqRGD0Fx1PkFrvMrR+cAGNCn+ps13YvVchYZQ5i2EhXUn1iFOaR1K245dk1iPuDs9B+XZScDLPSfvPBASchQPRzAnOZgp3RaCjHtNmHOqEdpTkHvoPt2yJ7dGodITfayesd0sSmub4t58FRw4wbkSU0wLEKcoHgAAFJv8ZkvgchHASq0N0z4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WB9Y+/BFhuYlwblQgGOTZ5xfc+8jFpkqWcv/oQbndYVoEh8CJE8pFd8vmCv/?=
 =?us-ascii?Q?maFWxpJPR9TupRX7QJjY2uvRkB+tQGhJjftkMc+LiyJzXYRY+oM3XcDKe2cb?=
 =?us-ascii?Q?DrfGK0b/4MMw0x58UyDkGL8OOa+pCqkluZG8ToTPmHex9FLIRKpwEVMA0rIT?=
 =?us-ascii?Q?62hTjoz8lyOJFOQkMaMylgZunUP6tKu+OovYufj7z1j+la835hGrZcTXSA57?=
 =?us-ascii?Q?EJZMSKhkzW88ZuIycImJr23cNrpnQejvugqp2xsPWXJJtQhDRSWtrYO9BIav?=
 =?us-ascii?Q?4Wlkgd6AmR9NI+XknzO3utR0Mz+1gOdLf0xH+oM7zkNZs4Bgq/cq3m5t8lew?=
 =?us-ascii?Q?7tgO0EyF37TJCK8zH8lBzL82KNey/kP+2dgWdNuREwohuj8uqDrXflk/LvGz?=
 =?us-ascii?Q?zwOgczrZjXJTDe0MYUbV0RwVyVmgIAc59GKXB5HcMdBaP/MMP+4hfDyhlVtH?=
 =?us-ascii?Q?9/OHb2B98bQwar2dCILgAlYjiq3nGnhbeadXqZOGSguB2wcJnX9kY00ZCoDi?=
 =?us-ascii?Q?rAfmEu6W7U0+eDMjrn2bhMPTKhGAMI48N9LQFBwSyMfCx8jnJwT3mShcNVtu?=
 =?us-ascii?Q?uDMY2GI4dyE0O9VUfposE+VW9A0NXg/Lg0xmirlfhEIEn7ZMNbraVSJtdIEm?=
 =?us-ascii?Q?JU6utLH3JNRZk9RlVd3rrJ3V6eRKxPHdOvL2+TS6lHXs7PVHyaRR5UEKQ2rv?=
 =?us-ascii?Q?NNeW7gqiHh0qeGPTxZsXA+bl2iuQaDLX9oIS9F1MH6lAAVG431+b+nSrNCD0?=
 =?us-ascii?Q?rJVqupvIw+yojrFh3Ad8L1D1BiUVUK6keUgQYqdFwtqVuBPh72oXoVT0BZAj?=
 =?us-ascii?Q?D9FoBFABmpz3VE2XD2987ODQxOic/nSFQS5aH548w11+68b2dxXR/MRiumkx?=
 =?us-ascii?Q?vHrKislAO7jD60pvOsoXwcpmlNSy/ASA50oPJuJBnL6ZY8i1y1oNo5DadJKS?=
 =?us-ascii?Q?QG0Bazq/gTWNM8sUvbgizUW1YUUECZetjNE0CIyGqt3etDXEyb8+RJnQmUW1?=
 =?us-ascii?Q?o5Cho2mBYBLhiWSLpX3yUgZBn3dzpOaBWS1TQeql1jc9PU6Y4IOHtExT7uer?=
 =?us-ascii?Q?pKu6LcsfZdWJnQopEVmbUX4sQT3+yrZDTHhLd5bgwvCNdB/5kktaSRH+/Dda?=
 =?us-ascii?Q?874s29RN4lydrtSdMQJap8Te8qmSE60w9yEW+ta/7Lo/Vm+9sY6OP80kV1VU?=
 =?us-ascii?Q?XmBv8zGuer/5M0NLuy35VDwnOR3mrgLUKyRhociBU4DPqj9lbChwp29lxGZT?=
 =?us-ascii?Q?JeFmCmbcW025kCLUC6bA1IL3Hhy3l/lKmxb+dy8w82ZFp21VjZ5jlRFp6eWE?=
 =?us-ascii?Q?Et0E8xAa/EtYKZ/aUMGO8nODtwpgz93W/4y+jHMA1pVLWfRZaKuWWqicoJzz?=
 =?us-ascii?Q?n614cNGihXBBajHKGR458LO3EKjS7/WeVA3bUM4mT0qkF0IueZmohoBHqs/y?=
 =?us-ascii?Q?AziWuLE9LQX1Vg+ErLqFAO7CbMA/IFW18M2Rlop+U/z5UixotKlRGcnsMCfy?=
 =?us-ascii?Q?v4uPRUP+GV1q3l+t+2z7JUFluMhT+SyI1N4qkr5A9Z+8XpAWNJunEcr2k7g5?=
 =?us-ascii?Q?goWPpVwOnjq8tEiqACqMnzRlsnylkLNkunHhmI2Jo+GUfz9KUCz+ZYJ1/nnJ?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124c3f4d-259e-4e04-8907-08dc34c09f12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:41:48.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWcI/UU7JlXx5nhzQT/NQAWssDf7PUPDzWOOBKDPROXCCBZkJbJVn605rmlDcsAx6vwkHIoyu+DU5XATvHmlHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010

On Fri, 23 Feb, 2024 13:08:34 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
> On 2/23/2024 11:24 AM, Rahul Rameshbabu wrote:
>> ethtool.py depends on yml files in a specific location of the linux kernel
>> tree. Using relative lookup for those files means that ethtool.py would
>> need to be run under tools/net/ynl/. Lookup needed yml files without
>> depending on the current working directory that ethtool.py is invoked from.
>> 
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> ---
>>  tools/net/ynl/ethtool.py | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
>> index 6c9f7e31250c..44ba3ba58ed9 100755
>> --- a/tools/net/ynl/ethtool.py
>> +++ b/tools/net/ynl/ethtool.py
>> @@ -6,6 +6,7 @@ import json
>>  import pprint
>>  import sys
>>  import re
>> +import os
>>  
>>  from lib import YnlFamily
>>  
>> @@ -152,8 +153,11 @@ def main():
>>      global args
>>      args = parser.parse_args()
>>  
>> -    spec = '../../../Documentation/netlink/specs/ethtool.yaml'
>> -    schema = '../../../Documentation/netlink/genetlink-legacy.yaml'
>> +    script_abs_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
>> +    spec = os.path.join(script_abs_dir,
>> +                        '../../../Documentation/netlink/specs/ethtool.yaml')
>> +    schema = os.path.join(script_abs_dir,
>> +                          '../../../Documentation/netlink/genetlink-legacy.yaml')
>>  
>
> This seems like a worthwhile improvement to make the tool more usable.
>

Unfortunately, even though in the next patch after this one where I add
the ts stats group as a comment, the tool seems to fail at rendering the
actual counters of the stats group, so I had to use the ethtool tree to
test. I should look into that, so that way other contributors such as
Intel can simply use this script to test that they hooked into the
ethtool ts stats interface correctly.

--
Thanks,

Rahul Rameshbabu

