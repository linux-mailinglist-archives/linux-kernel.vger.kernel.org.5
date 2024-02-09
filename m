Return-Path: <linux-kernel+bounces-59857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267784FCA2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25858B249D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5133382867;
	Fri,  9 Feb 2024 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zHwM5GPP"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86C57861;
	Fri,  9 Feb 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505560; cv=fail; b=k66AF+8KKegEP12lF9mtgn1NZ9ER42cyWF/gO8aGYbixTMKTXPg1qzjtQhYzuhp7yEBrmrHGel3c3hTl+Tc7H4vng9xwtJskPixx8V3mHf4dBs4aRDXSl9Qbs2F74DNJKr7JdcsjD/MKd13WhyqsdFydvpXEE/hUpRV0j1My9+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505560; c=relaxed/simple;
	bh=AHlA1rUoOJyMvh11Ppa9lUT7OZNl9mrhw5s903iJW0s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XOQrHtWZlN9svdtppxkYFeScinKaJ29NzXEbVuN9rir2+as4FIxQ4Bhu4SzSonz/SmYukXYlW9AYheE/QAzkILLal3YWIpliIa4EIvsry2G5BQATt1hhQ+Iw+ibJ5T8mT40Q5XX4seHwf1P7UxPe55IyOVhp8bzq/mH5a/xP1gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zHwM5GPP; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFp9bLs8HY3w5LCaz2lGWsd4dFONCgZx0ZmpObYVVV1+wAKsmmo5xyapQOrXlxxo1KVsfZqtcd3GV/C/ODl3WwazxP3Gglkepg9Qft5ufsO82u+5+l/oSt611p56aa/wufwlrQGU6o+AwoPso1OOy5I/v9NxriGJhIYXShiAVXhFCUO+q70Wpm8YXfAGkSQ1Nge6l3zITKgREY3d316W77E6r+JL2tgn/p439JcXgtAq7vTay8/A7OfJBZoikrybTnGJV4wb/hCA3GVcuipej+hNZw6e2tmAKedtMvwCQtb3sEnyPEjWuT1kEHG+3mI4kGw3sNbIADu14l9NqRTFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfO0gKdDon1PSRwCYTq5dg4J/lzARl0aSBeoQT+M7jU=;
 b=DM1rNJRed0r2xAOMc3ZyHiIbNJekxP92ss5yo36w7Pss7dJEEjIANYcPzTobSNVAtdXFT39eaY36gyfKXxpTwZ+wqnX4Qpm/tL9CXIVh7F/6qOz8pPwWoVWZVAEydaB9dMYMrUMEX+k4rsISfQVhf7xqQ9L8GvLYvvZnoUF7jSmEjA+GbhOXtvuhYpyXIIsqZT1aNrG1dNFHIuVtv72wVckyEIrKNpYfFmH8PuwRZb8XqIEbxhymELOyB8FWf+uU0GKZ9i/2Ph52T//zNZWEGnBVZ/q8R/eS3sIHHDK/qkn5nBBl4Kkk541L+Bk9QFTuvOOi2de87yWrdGZV45u2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfO0gKdDon1PSRwCYTq5dg4J/lzARl0aSBeoQT+M7jU=;
 b=zHwM5GPPwkyx5hq6XM6CdbYWhqix38ix3c2FbHabdY+HsnXvMa/nbjXvelBnMI29+ICTShW9aAvu3+NLwh9WwgvsjzN6FNQyyyWxxkp+UX2cUZP0dXWmFFnmIizZnSDaWxasRAWekLG76kH7PYdiioU1JQaqoYFX3ydr2FCakwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 19:05:54 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::f44f:4aa:d49e:d055]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::f44f:4aa:d49e:d055%7]) with mapi id 15.20.7292.010; Fri, 9 Feb 2024
 19:05:54 +0000
Message-ID: <a9b139fe-832d-889b-3d1a-2122e9c26a11@amd.com>
Date: Fri, 9 Feb 2024 13:05:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] crypto: ccp: Avoid discarding errors in
 psp_send_platform_access_msg()
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: John Allen <john.allen@amd.com>,
 "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..."
 <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Tim Van Patten <timvp@google.com>
References: <20240207215439.95871-1-mario.limonciello@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240207215439.95871-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:4:ad::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 527e2cca-67af-4040-071c-08dc29a223e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9DgSZoWgHuBZEyZ/wHxsWBYKqdR/CIaz4EncEJJMz8Cejca87tq2v+ngQX/2i63SH23qGsYNPqA2ZcDG4xs5lrbJ+qf9AbahNydN+90Gu8sjkqRu+2MBi8F8egQ6sMEGFiILiP1goTUBZ2+GvFZR65S/ZkMqurtgV1FnisMHMLlUDi4pQLLJDl843GyRR03cIa6B6ftW4y5piSAXXRPxwcpOLDXNEJEs7H+sQG/j3QAGCZxGRl3zyckYHGkiEEiq52zfNcLJD0qF2wX5a2a92FZuWuiVI9d9Jtl4F6JspxdreIT0Bri4d/NoUdRVFOwxSI5qrHeK7TQKCM8qvUxYHIPk+7UROuAFUN1ThQTm/WoomXs4aAGgkVPPojLnjdIcVubfpq7IcGAtT1S3i71buPH6vpEtBfjvs8QQBhZytQy/nCeInlc25Pkj8kXld07F3TSI1f1fUu/8WDSpS/3YV7ZzzrOi/CI7EVTrvAEz/xh11RSKVrfTIgV49Ukj9ADHQ8Uvv2hJIfvPkAtoTxrr5QmoNzQUezgTkns+PGDSrCxdgm3vQmIKpxQO/v2NSTUn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(8676002)(66556008)(66946007)(66476007)(316002)(110136005)(4326008)(31696002)(8936002)(5660300002)(54906003)(41300700001)(6666004)(6506007)(36756003)(53546011)(2906002)(86362001)(38100700002)(478600001)(6512007)(26005)(2616005)(6486002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejU3OGdsTG9EcFZkUFE0VlF3bVhFaGh1Ymt6Y05LY0IwQTFUS0t3QThqVVhZ?=
 =?utf-8?B?cnp0WHRNdmF0d3Y0QUdOK0tBWWZpdUdyR2VXb01qaCtOdldPZXVJZUQxOVFF?=
 =?utf-8?B?REJkQTlabTdLaXQ2MGpkSUdBak5OeUk4UTVvT2lZRUJXQSsxSFlVT3REVEd4?=
 =?utf-8?B?MER1c0JqUmtoWjc2RHJscEQ0bWIzN0xGU2V5R0hRSzdMQmRDckY1Zy9sOW9T?=
 =?utf-8?B?cW5NR0lNS1NNeUFzRnBpc1haaXVRN2JTZkNKSVdvbkc1bmlzRGpWSmxBZ1JZ?=
 =?utf-8?B?TkpSSi9TNWtZTGJMZUpISlpWQW1ReEdZcWhwODhTbGRSZFl0VytLOVBjUTlF?=
 =?utf-8?B?YStnZVZSMGUxTHI3VnIvemxvRDY2SkxLWHdodXBNMUxmVzJOd2l3cnBNR3Uz?=
 =?utf-8?B?NnRUb2F5eEl4UlBMMENDUjg4RE53eXFGNHBDSE1ZZnJvVEUxWktRdkFraStw?=
 =?utf-8?B?TEFJcnV6WUtGbjREWXhST1MzWGM1c2krMkJLY2tqUUV5K0g0VHEzQzVJYXBj?=
 =?utf-8?B?RlpCUUVML01vVmJFVGdoWHU5RGxhK2pjZjNIb0lVV1MvamUrMjZ1ZUg3TTZY?=
 =?utf-8?B?bnVRdXdSdXB5N3htdjBFSXBmYUFJd2c4UE5FbUl0Qm40SEpRU2xWYU1vNmxs?=
 =?utf-8?B?NUFNOWpvakFMVkEycEhBKzBBZURHVFlnUmp3elhuRXVxTlkzbVdwWkZzTjM5?=
 =?utf-8?B?WkRyWWJQZjZWZktncnpZTXJGTzZ0a3BTR01EclJ2TGxsaGxWRFdlVUFPYlgy?=
 =?utf-8?B?NDBET2Y4eWxxL3lnbDE2MDBFeWRydVRtWTc4aUV4elFPbGpVa0Uzd3BkWTNy?=
 =?utf-8?B?Qlc5K0NxdVNTSyt0dUxhcVk0UkxUNDJyWUV1SitqaUZTUC96QTlFc01pOWZZ?=
 =?utf-8?B?RllpV2MrSklnbEVjeTM4SUJHYkpaa3k1aDZ0UzhkeThQK3R6TTVNcTFRVDZW?=
 =?utf-8?B?Wis0cWlGcjg3NTd0VmhFK29pUkdMMDVNZSsrazEzQURQRlgyT2NiK3VUUnhB?=
 =?utf-8?B?aGg0RDVXT3lTLytETktlem1TcGRXVFEvaFllZ0Z4MXYxNCs4U2pueUxML3hm?=
 =?utf-8?B?VmwzbXNrT3Z2SnY2Rlp1ek0xOG1tNW1tcERzSVVINE5HTUhOdFVMTVlMbUlU?=
 =?utf-8?B?NWxFdWlTdjhhdzNCQVFuWVk5aVk3bW94em5PM3VwNVpPMHFjU1hnTU9qaFcr?=
 =?utf-8?B?dWc1Q1Nxamh5VWd5YnB2Ykd1UlBZTlN5bTNreGNFc3BpTHVjOVJ0Q3Vtblgy?=
 =?utf-8?B?ZkFTN3FqOVhOaXBhaGd0OC9UVlhmWDRUUXgvNm9ySXR6SEt1OGFNaEhIRGJX?=
 =?utf-8?B?Rm42bDh0Wi9CNDRxYzBMbmNZWm5IbjZIWDlrM1cvdEQvSFE2RGJPd3JoSmtL?=
 =?utf-8?B?aGk0ckJkUmErR0ZiK2pOaDVSY08wb0hLR0s4TS85blRSdm5VZDBzUURYVjRi?=
 =?utf-8?B?VUhhZnJtTmJMaVMyS0tKWlhtRkd4NzZwZU51TFd1WkcyanVMR0lCUmNoZ1Jp?=
 =?utf-8?B?Q0FoK2poZ3NBN1dkSmY1N2MxWk11OEIyWnp1NDI1NkNTSUEzUnllKy8xTDhO?=
 =?utf-8?B?cWpSc2NOYzE0TmJHTTNkSXBpNEdKK3pkSWxDaWFBQnJMNldQNUtNNFJNY2dL?=
 =?utf-8?B?Z2p4QkNoRGwxT251ckRGSzlyd04yVDRUNFVjSU5OdmdCMVl0bGJEcjB0QVov?=
 =?utf-8?B?dWQ3b3RveXRCUWcvZTJkaFRUTldnalhiNFo3SVRodXBLaS9WSEpGS3JhYjgy?=
 =?utf-8?B?TjcxYklUTWcxNk1INmJBYit6elRueDErcWFNL1ZuY0RReUFGbTcrSjllR1R4?=
 =?utf-8?B?eTNGQVgyUXhkc2s5Y2gvSGZDaHVPOVlmVHhhS2V4QUxDdzJ6cElxQWpwMWh1?=
 =?utf-8?B?bmtLa1Q5QlUwQlVvUWp1NTZGd1J4aTdWMllhZnUyUGcvNFZjWGsrR3FINjBt?=
 =?utf-8?B?OGFLOUJLS3RoaEFuV3VXa0J5eStQZmZvZ2VvWHVHVTUyMmh0eHpsUTlrTUNi?=
 =?utf-8?B?RnViU2pyVU1NYTQrQTdoVmhHTGN2clBSWjdKSTNueUZ5U0Nza00yRWorZHFR?=
 =?utf-8?B?UGNwbzJ5SEdyK0pQYmRPQ25HWTlxTkxaaER4TXBWVFkwYSt2U3E3YzM2aE1T?=
 =?utf-8?Q?4CnQJ5uCihguNqp/A87rLms8T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527e2cca-67af-4040-071c-08dc29a223e3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:05:54.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THmUttEaXxOhAAAOPJiZT0ucEjdcCPV5eykxC825wuuZtzrOsXkJExhap5zyW5X7wUrIuvdhzQ2mjGQg2sXngA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

On 2/7/24 15:54, Mario Limonciello wrote:
> When the PSP_CMDRESP_STS field has an error set, the details of the
> error are in `req->header->status`, and the caller will want to look
> at them. But if there is no error set then caller may want to check
> `req->header->status` separately.
> 
> Stop discarding these errors.

This needs a more thorough commit message. It took me a bit to understand 
that the value in the request header could be set to something specific to 
the request even though the command response status comes back as zero.

Which also indicates that the code below should have a nice comment about 
why you only set req->header.status when PSP_CMDRESP_STS is non-zero (in 
other words the existing comment needs to be re-worded).

Thanks,
Tom

> 
> Reported-by: Tim Van Patten <timvp@google.com>
> Fixes: 7ccc4f4e2e50 ("crypto: ccp - Add support for an interface for platform features")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/crypto/ccp/platform-access.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
> index 94367bc49e35..792ae8d5b11a 100644
> --- a/drivers/crypto/ccp/platform-access.c
> +++ b/drivers/crypto/ccp/platform-access.c
> @@ -120,7 +120,8 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
>   
>   	/* Store the status in request header for caller to investigate */
>   	cmd_reg = ioread32(cmd);
> -	req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
> +	if (FIELD_GET(PSP_CMDRESP_STS, cmd_reg))
> +		req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
>   	if (req->header.status) {
>   		ret = -EIO;
>   		goto unlock;

