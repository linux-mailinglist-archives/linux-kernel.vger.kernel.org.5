Return-Path: <linux-kernel+bounces-103603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B051E87C1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D400D1C208D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E07443B;
	Thu, 14 Mar 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y6KfIJrN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B07351C;
	Thu, 14 Mar 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435963; cv=fail; b=QespXD0aVz5V77C91ZEZhsMX7/Wx5T+ve0iHYud3VcH/g1WQd3Lx/tOVTd4p/42K+dV4EYM6duSuRiKqSAq52IHiSqA43bHXfmjmFTE3kQnDcHKPLaRUMh+Ah9/0+qPuNtZtusUSzAdfePfTLTTBrX8tBpiaWHoqsmDxNKlVOtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435963; c=relaxed/simple;
	bh=YPnnMNYYaIMouwvU1TpY5KYCqbze+NhetAtLsX+OZlY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=APGoutOBdHzH+fNvef/Wy58u2z49uw7OE//oN+0B46jtXf7SWLykhQCiIjqSUwxyCX1L86KPuKLq8XdDHS+J7wn/MVzvukAizf4Amapd4gFE8zhIj0duR4koii5ln4JXidmtFUcuTWVQ6+8paqu+QSLxijhsM4FKHr+NPq+77dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y6KfIJrN; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9IFS0+UpLKHie9waF0QhSMAWZElqv5P1RuLzKWOLRHTN4+aN1vfov1CC/9e+j42mjKlzcJDEOokhDsMNiErnTpgpWNmM8WPI/Ej/nBy7FxUzwGZrdFSNng9GFDdR70s7sKI4pOKG0ab/Z7bPxMm2MVIq6bgLx+ml32N+nSfdMD/aZ3ujtVqUj9x6EU/ujrKg7EdWyE13hlKmpx2LzB/n8b6uQYF9eFT/5/zdDKcXM2YQXdF2xy222T+ZljRcXhQjknsY1Lyy5fJeIzhhOcyzx+B2Rf8TuVMCPxkZ+F9DDFrXXJvHhXJBhI+ZjI/21muGnrk5q5140U8/lWIP/1W4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pREwHxAS7Q8wNFPjU5JGXzl/6uc8DyA1T++rmnUwTgU=;
 b=RKiAY7N+W+vohuzKX9uHMq76ELTLA01OxUxZFTUTje7wiSU15rV8vOtNd2bLzCrz1PBqdk6LefaOnU35jAlOu99+DITQYZZ/hsSLwgRNInTLEvGvXVq7SgZoGso6F8J+YY0iFMuhcXKuR2nV74C1Qe3zN3hroAL7MQ4tSe4MEdg2tOBYGAOzMvLHFGpuyMAt5G4LvAG8z/BRomcVfQJo/C0+0dmGIPOL03VHriZwnZm7AFMLMMFRrsRoi0AQj4pf8l85wbsmBZ/e1bpNW97VEP+3sas1cNEk8JzJ+UzpTVBOwNopDHa8S2psUZL0FYx4H55OT7GXfP1zwXmD3Irwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pREwHxAS7Q8wNFPjU5JGXzl/6uc8DyA1T++rmnUwTgU=;
 b=Y6KfIJrNOK6s0ziVUnKVY8QHoDK2TJ23nMUpXcqnWhhSHp4Dyfxe3PtIT56Dvu0KKdV3wzq0ZtAl8g4GdTfTa+s7D+Ak6zwcBMx7kzuxoKqgbX/NVAcN4LDBzxY7dQlSYVNdYXK+23EEl+isbBQYwrUq+FXqbFGi2r0WfFF6xO/jho/8WGYAKI4/dqZFBxOMuWkIXlbplyyy1S/a4TtdiiRgP+WIIcIUNeV9P5ni6+2Sm+IgTKZJD8GmNMyjCc3rZGVD195JtpLKWMhDXw/U27MPdQDbrtRV29nzegQ+kexlPQDm14mGZrFNbpgRuzWeJdgEekelsRrhl8dUSsrnyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 17:05:56 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 17:05:56 +0000
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-2-rrameshbabu@nvidia.com>
 <20240312165346.14ec1941@kernel.org>
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
Date: Thu, 14 Mar 2024 10:01:49 -0700
In-reply-to: <20240312165346.14ec1941@kernel.org>
Message-ID: <87v85ovj4d.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: a898300a-3c5a-4b34-4f77-08dc4449036b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	02ydfTkSYF19hICshItQ+HCqXVb5XiikBocXNJEX9QMYBlrK6lLaIWPrJZU9mR+5sh+NCbw7IHljSa8WctlfHzc0EKJVXrBNET7tR/PiDyZg67994st5Yl96DJYtF/g0GIe1E76Rdp2e/cPWxIpNSc7sj7I6Y5AOWpyOpPSc9c4trCoPxi25BC9RB0NawmS8ce3BhUrtrcZqxjDNR24yJ1as34BwaJIzwT7abn0hTLmtZFshvIWznwoweO0ydV1xcSqrk2H9cw2JVrTgArE2eHdJ6CPGHD5AlfwvH+JyGzgVCDZ2na0cx8ZQ5YQxXRHSuJvJl8kYa7cM9RzPrZ15rD+kfSVYws7kKm4PTXTSGclAh7MImdJsXMNBG0ctElCTdthDur0CQS2RextCHvyrdY0ZNsp9AhqNWwCC3Rhy90oyEs8DzZV/jfEUiqPsaFKUQYIl1g2L8hNxpNGeboMq6gZcQOitEUyz0wKtMSsOBZtmNEEO2q96/Q3bbS0Nx1zSCnUSnw0DRBIHgw/MWO0OTipTRR/aRh358jxid9xbg69H07WJqR+EqY7GAgZjmI4v1y4V/e9RMi4GxaX8Ib/i8/Tmc1maAUFNopu/NjG9PWYywERoATs4FlZ8KNCnsUGP2WiHBbmdWQeYV4gylEMeLEExWNpLWKf4PTjj++x8hEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VN2BFuPYaPmzoW5msA5UyyR+mH8awecrEc4jnI/mCQ1aycj/MJNGC3VqO7eO?=
 =?us-ascii?Q?o5SmJXjcQiPOyE/Q/827lTvwse/JMlYKAlvDAgogzQhXhKctyPNU8yLuqIG1?=
 =?us-ascii?Q?3vfHAYIY05MoW+n1FUfLEn19JVyzQkEU6Gg08+F/ccAMkLfx5+oV5GCm/CoS?=
 =?us-ascii?Q?hZPjsnqE3hZZDyD1b/Zz0zNZXKwP0e9jVZf4QcTLhzoN6yWis4AFLKgoEoqN?=
 =?us-ascii?Q?NAsLvjQ9Vpwe7gS8CMgOqK0GxT/ZGhwWJvVxPWGakA+bczoE4Yjg+jAmUYRy?=
 =?us-ascii?Q?E5wRk9ssPJ/uLAR6g0OfG4KXzIvO+R+/Z/Z49/ymBDxWwoglIJjD5TIM3aTd?=
 =?us-ascii?Q?fdH/iVoqnWCfxnhltNNRMBj91vW6nvE7/vK6ZgKakKpiYClJ3VhaEHKrCQiv?=
 =?us-ascii?Q?LwNAlp/3GtsD8dmLnzqB3i5a8HZft/OkmCjdUBzTv74BvZTTTNX5W5M9WkGR?=
 =?us-ascii?Q?7UU5OM2xy1ccqRs0HPSdEgGmv9hG95wkiPxJLMXlhLSyGr1wYgTVOWIWhAG6?=
 =?us-ascii?Q?8Zb0CMdjQ+SPUuzEnB98oDIDhp0m6b1QPLwrDklXH3fjawIA3XNruyPug7b7?=
 =?us-ascii?Q?355CcezobwXsjTv6aPmOsPP0HNB69KCyT27CNhoCluxBT+cPNa7N5imryKAd?=
 =?us-ascii?Q?hjRlSsJ0pxerGmfSfZ5epfpI5aaB8d9ENkeRARWQDZMqsbGttVfqdgKB/bJ/?=
 =?us-ascii?Q?NGKcP0kt7ALX1BjBC053RcNSdn9gOXky6EiWWtB3ymHpTEnMrJmOM3HT7FtS?=
 =?us-ascii?Q?rh9QfayxfZGxMPkLKR2mrbSr7uqEOaVWW8UHs64ltKxqrSUq3A/XvKKHXxBu?=
 =?us-ascii?Q?0N3DgGHbNA97FEpbNQfjZcHAiBCX+EktA0SueW1ffL9tuc9qQgNoffzpIl5Z?=
 =?us-ascii?Q?m7dv3PxfA8DQu/jpPQRyfT56k4f7dbMbdYMswHcQn6xAu1DNyzRVV1e4t7Ss?=
 =?us-ascii?Q?KBZdmyBQvvdffWgqx6RoXCowT+6e3fTh/1lXbUtPQe84Ic+PEl/wqR7gGDIp?=
 =?us-ascii?Q?uREb+Vi25uV1AUgCDG8uppFZlYun7v/lFu96ubFkpacEvD2oE+Bp0dkNraeE?=
 =?us-ascii?Q?rYbfzB1glBifNZqCSnNUyUX+8rwmGsGSOqndnxKj8AYa9e8kk4RELNLB6qvm?=
 =?us-ascii?Q?Zr4ZFqeC++iBjycrlSskUsX6/ZwXEWryMEJ22EyH0b8tGefFfSi18kNcER1q?=
 =?us-ascii?Q?+drp11f5s+08Qs2brRuqYbhU6TuUvJirREG8oB+eRopqGMs7yO1Onxws5m7/?=
 =?us-ascii?Q?9GR4+J/ni6LU/9H00zXrxi4JsBpWlQllgceAFkMn3AYOo4qQqugxHnmj6Tqs?=
 =?us-ascii?Q?vNPdIiHN2d0ptlmtHF7bmDcWgZ+eSUt82tf6no+IJO0w2aWAfhszSLvUvQTK?=
 =?us-ascii?Q?yl+jkEwesmKmvwdvZ/WPe2hegnArnjKNWZNmEwSbopXgGdAS3fhoKgA15wkO?=
 =?us-ascii?Q?Xrur/7E6mcx03xq8nfSAx/klBBbHtsejHvbj9ngErTfdBJ9zza4mwH4tqe8a?=
 =?us-ascii?Q?14PEPCdaeu5ZdIqkm7MxddqLtEKFi4qTQOWRUlcbc594G898+K+pjrx7JgDa?=
 =?us-ascii?Q?5CLEmXvl8pdnjdpV1zVOmz5q+mRDUvu402/ToULeGkcy3B227bcZvCh/FPq9?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a898300a-3c5a-4b34-4f77-08dc4449036b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 17:05:56.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ipe8ROyK0zwhB4i4BZDoqkZcOvQhGXsx3exShxCaTgrfc0oTLBwBz/q5I+XAEPq4IqjZUNRHnecjmu22AC4fjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573


On Tue, 12 Mar, 2024 16:53:46 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
> On Sat,  9 Mar 2024 00:44:35 -0800 Rahul Rameshbabu wrote:
>> Multiple network devices that support hardware timestamping appear to have
>> common behavior with regards to timestamp handling. Implement common Tx
>> hardware timestamping statistics in a tx_stats struct_group. Common Rx
>> hardware timestamping statistics can subsequently be implemented in a
>> rx_stats struct_group for ethtool_ts_stats.
>
>>  Documentation/netlink/specs/ethtool.yaml | 20 +++++++++
>>  include/linux/ethtool.h                  | 21 ++++++++++
>>  include/uapi/linux/ethtool_netlink.h     | 15 +++++++
>>  net/ethtool/tsinfo.c                     | 52 +++++++++++++++++++++++-
>>  4 files changed, 107 insertions(+), 1 deletion(-)
>
> Feels like we should mention the new stats somehow in 
> Documentation/networking/ethtool-netlink.rst
>
>> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
>> index 197208f419dc..f99b003c78c0 100644
>> --- a/Documentation/netlink/specs/ethtool.yaml
>> +++ b/Documentation/netlink/specs/ethtool.yaml
>> @@ -559,6 +559,21 @@ attribute-sets:
>>        -
>>          name: tx-lpi-timer
>>          type: u32
>> +  -
>> +    name: ts-stat
>> +    attributes:
>> +      -
>> +        name: pad
>> +        type: pad
>
> You can remove the pad entry, and...
>

You need the pad to match with ETHTOOL_A_TS_STAT_PAD (which similar to
other ethtool stats currently defined). Otherwise, you run into the
following.... mm-stat and fec-stat are good examples.

  [root@binary-eater-vm-01 linux-ethtool-ts]# ./tools/net/ynl/ethtool.py --show-time-stamping mlx5_1
  Traceback (most recent call last):
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 598, in _decode
      attr_spec = attr_space.attrs_by_val[attr.type]
                  ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
  KeyError: 4

  During handling of the above exception, another exception occurred:

  Traceback (most recent call last):
    File "/root/linux-ethtool-ts/./tools/net/ynl/ethtool.py", line 437, in <module>
      main()
    File "/root/linux-ethtool-ts/./tools/net/ynl/ethtool.py", line 333, in main
      tsinfo = dumpit(ynl, args, 'tsinfo-get', req)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/./tools/net/ynl/ethtool.py", line 91, in dumpit
      reply = ynl.dump(op_name, { 'header': {} } | extra)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 873, in dump
      return self._op(method, vals, [], dump=True)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 858, in _op
      rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 607, in _decode
      subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], search_attrs)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/root/linux-ethtool-ts/tools/net/ynl/lib/ynl.py", line 601, in _decode
      raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
  Exception: Space 'ts-stat' has no attribute with value '4'

>> +enum {
>> +	ETHTOOL_A_TS_STAT_UNSPEC,
>> +	ETHTOOL_A_TS_STAT_PAD,
>> +
>> +	ETHTOOL_A_TS_STAT_TX_PKT,			/* array, u64 */
>> +	ETHTOOL_A_TS_STAT_TX_LOST,			/* array, u64 */
>> +	ETHTOOL_A_TS_STAT_TX_ERR,			/* array, u64 */
>
> I don't think these are arrays.
>
>> +
>> +	/* add new constants above here */
>> +	__ETHTOOL_A_TS_STAT_CNT,
>> +	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
>> +
>> +};

--
Thanks,

Rahul Rameshbabu

