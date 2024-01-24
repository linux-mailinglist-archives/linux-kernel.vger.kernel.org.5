Return-Path: <linux-kernel+bounces-36715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF95583A565
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8589F1F21B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FA117C6F;
	Wed, 24 Jan 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="jTpicxty";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="DgqggiEQ"
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497418032
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088443; cv=fail; b=tQjNDa447kWQ3qMg69Ig79loi8CjRL6UfDZAv1wgZozBZeFxdAh8ziH8jbMHJ01BnvqPDL57XEg1fa59viIn38C2wBTQPso/QIQRQ10QgxBNNAo18ygFAcEfwpL+zv55P/TmWfMGghvhj6uBAHZP0OAQQgiH8FbpHKvmGRQY/Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088443; c=relaxed/simple;
	bh=LQQ4gDDlFVeWSeOrtAkG2Wvd3O2mXoeh0OXBtb0I5/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nFeJ7i9vmqF82eSGlFcrBcmtUEWTzicYK8y3icW5/GcJzpZ7DtW+HMkU82ZcUD1bzgtewxRwMIRFPDP1Qt3LNAaisAyuEBn6sDemDAcBfxbI8wp7PHsv+LrcHZ+h7rKcAlgJ0BzXLr0iZp9lM3yfYjjN4ljYxKPKHlOlRf9k6VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=jTpicxty; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=DgqggiEQ reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx304.security-mail.net (Postfix) with ESMTP id 84FE73CF988
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1706088432;
	bh=LQQ4gDDlFVeWSeOrtAkG2Wvd3O2mXoeh0OXBtb0I5/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jTpicxtyRAj6xe/zyUVAJODtBIODBBhghunrZnaZFyeFGMhi0ZIlCMcTYELCddOZr
	 wVebntr8ir22QjuTJbt/G2TA51zYtzEneVCSIc0JbejvVBcdlXfq+0m3oFdVTEsRmo
	 Z7IOfHvDUftUWFhHLtinfYFsz3COa/p/7H/E8HOo=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id 5616C3CFA0F; Wed, 24 Jan 2024 10:27:12 +0100 (CET)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-pr2fra01lp0100.outbound.protection.outlook.com [104.47.24.100]) by
 fx304.security-mail.net (Postfix) with ESMTPS id CA32E3CF0D4; Wed, 24 Jan
 2024 10:27:11 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by PR1P264MB1888.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:27:10 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:27:10 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <9e4e.65b0d7ef.c9711.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm95By2Nbm80it/tPCZZJEyRIe7kQrtjtaRaZQieJe5g4/6fkfLTau9bywRTcfFeM+4ObOzZ9ti+ViK2mCsWDgucRmP7N6/4c4DJuQjReJ6k0mIgBcyC3/72WxBb7HK+Ghtt6rm9bCB+R3ZODlLqWX8sSG5TquqqXl9My+8zT3q+uB0a9C5a88FAblGRwxtntvAeX9nOliB2q/MZmFW6QHHVwVMycUs5PrFPh2NUBmounDLL3FZOpkDAbhEpY0q7CiimRIw8fpPLPdPPXj0WCiVy1C5888YbfUxsrDDMw+HpSracMBTRqnb4mNgFtem2F53ezioJMrTRc8dBx4CAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdPdozyo63d0wBWY3uda6mzDRg9KGRmOmy0ShaKvs6w=;
 b=RygaZ4WYNslbwj45xcO+kD5+EIRw69zADLeXn5p6KP1wqEP6qk0pu2ZOM5I5edsYaKhw23Ew1JLu6T/S33uEibYjRMHewUgV+QgvEKIw0HxHmr7uy2m1zKqYp9hxzU8d8gWUwPFMT95lMvYrqFi2WuW2dYyiB8i1wNWcbTGuLV1Dnflk1ooqL1dUlUmIYvISBdePpHvgkc/li8EE9KzvTl3VnFtNopltOVyk8V60U9YWWXmYmBu9t6Br56Q/1018lnHPKJdbk50Kv9D0tL/8Ga1uDrk1zXeJw8T15qdQvu75BxC58Q5d3r8TbdsfB349G96HtowOsEz/cNhfGpZFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdPdozyo63d0wBWY3uda6mzDRg9KGRmOmy0ShaKvs6w=;
 b=DgqggiEQNCO9qw1xDMsFggv2cHpWVXnRyTcA8eeSxtJmBjgCGryP7Hmj5LlHWKsOXmE6YaZiKyNoeLpvnf0ydoKAaVwZooat1O9aZCMxUZOwOKbY9QZ11j707FGsk+e6Fs7zVtuuUUzLLjCatfVdRNFR3NNXMKXLb6X27KxnRdtEvwtEr3izu2/UYLVz8jzj/6X3LjQAN2QR5xDDDaEoT920rppi4ppGKBtgdYHTj+93O84Luwl344rSEp0pabQpEwQ/ciHsFTlcu/JqpWLK7JEA2/eoKdQK8IW5RUYjdP2WFgSu67onpvloIJGN+OSOCIp0a1RGsAxO/kk5PJ1jRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <a10c50c3-6c65-4de8-b8b5-9d2c798ac658@kalrayinc.com>
Date: Wed, 24 Jan 2024 10:27:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/417] 6.1.75-rc1 review
Content-Language: en-us, fr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240122235751.480367507@linuxfoundation.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::6) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|PR1P264MB1888:EE_
X-MS-Office365-Filtering-Correlation-Id: 7578405c-4be1-4d21-95aa-08dc1cbea3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ck1s/BYsr8p2t6FU6rZxqdORSLcITIg6Dl7TUx/q5nCJD6xH9zxsaR9Ami+m5LDjW0QHcRnJ/oQ+1J04xKOJwZ+hHgsZBJ7hbyvGYJDZLIBTwmze7HjedBodKC7sv9smwc2Zrb+9jFApj5VDPKDWWPQiorpRwT8drg2dBNL1LynKC+2RPeao6Ao6NyLsyUSUHFeEtaVhnTxiHWxt5MjVSz/V4pH/C8bDMk6iZyimkHm9JS9GbFPkHuBpUlEXqC24N8sznzlNL2VYZp1ws5MJh3Axjmh+E24LnZm/9FEHupJGsa5qOcxiZHnwj3gAZ7VTAzC4v84FaLUXnSLcf4sLyF3eIGuXwxFgv/2tfOu2NnGYKXcZ2/CDtoZLctkJ8F8QXmjxXZiGgdxRXKMGKvJMYm0rJqmLUyu5HJbuIlUloFxdtkXFJpbOjhMqhblE0Su5l6v0VGHYiST+g4FAIRK8jStyor+YNUWTOpDD7ibBanarVOhInMWY3fHnht+J8jT5g+v2wNTFv7WurUVOOynLc46HhJ4IkUJKAJ3PkVDHZWP+0g/ELz/d654SQGVyn8mXrW3Rumb8MZjC+byBIbBLhRNEavdb9p8wnyI3vUzjEbt1o+G6E8kkvhvQ8Rn4TUag1xEzpOv4frKYJFVipAoeJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(136003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(6506007)(7416002)(41300700001)(478600001)(6486002)(966005)(4326008)(8676002)(8936002)(31696002)(316002)(86362001)(66946007)(66556008)(66476007)(36756003)(31686004)(38100700002)(2616005)(2906002)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YEZMyxOnEHsptEzhhX4nynoA3PKXc085Lk0tuskp2zLQUaXkxfO24JKzXpkQ29p7o8Mog2A3Ogm95bWfsClm1+QAPfmnJcLeCxHFa5syY75/ZgDKkXiC/0BA4AxbCLeCngxi360gjH6GQp1YWE6GTDK878IKs6NIfREiqpDhbTfBpK6+PI65gZQc7cL1UFP/xo98jjlrSPfaRtpRxRfmPRTgc5i8Bg5nXKAbd0I8xo6s4AtmIAX2wZ96n314zttBp7PT1HCsEZXVrufDmL8YqknF4rw6xBwhR5UlsKy+kmDoonSeW5Q8xJIWdxbjfRNBZN+lQbDxVin1K0etDw/AQW8joSZD3DKuuHTufLBbZt5lRrOV0EUj8l1X8K5oKKCcGqTXdKWZJdNWwEyg0qSWx2xrfZWtn9Eu6AahhaS3a3mHeIMa4PcafDLzvcwypJbOshof6mbJ2i/Mke2xfPJLO+nAqWxbs7O73x2V9aieyJ2VU/5z4xDzxSzLPLHMTDTX29YXujtB9u8EfczlsYC8kukTbDbFwIB+KU0kyrYr8cpopGi4n27EGoTyvkuFZnB1mM8REau330rOex4VaS5q9lVf7TTi4z65II05UbMbQ4snoZrLWUQ6HkIftNGTSzAAS0dwbdTa9J64C9kZTjdhqTrsu0+/Lweu8nKk20F1R2roQEJHjPoKoNfxeF8BvGBCu/3fRKB8HTWVSC6KT/81l/jtVUhTNkVI3GwHxjIt7o0PzaWFkiKhkHYrcE7og2a4tmXbw913hsd/L3cSKapUq2JpaleCUEPGjO5bWmPokiTojMs4Gc4oNlN1w6BSSyXEce9sgVqG238VDcv3Ljq/okdi33opYoLwi8kEMvYEdpgf9C8VoYovPUCtlVABqfLPhMsVtS1NgcxI1LK9ieVhJB6xfhtOnu0/v4aFtLqUijK722EvTpndJFxotk4M2X5K
 ETL0Hj6gB5qnPneWaAZ9XZT7saGvwKNFSj9CTcUrNJpjtmIS/LwmqCxb4gyNXeRWyVCvN/qdaNiD57GzcAPSqdTak1OSc9QJcn+NXlvpLJgz5Q9Okz/+E/msNFwnnhPLvcdxUmZN+ReisPmz5odsbgDHURJ6yQUUAXm+X8gla0B+fdGnCyB7PbwXSyPeVEIs18AtKclHEDruWrxJ1zA13HXekzxFSKZcT6YTr5tklgbYlbXisrkJd43qA08M1X3LBCopQCZ+Al3rVKqzxZkqSKGq4E5ohh4HE1zpot9EHFjind7+46CnE9xAWUewp8V5JTNE51Z001BxnwvX5ZLmj2Wwm33dl9RH7imUqY8VMhW0FS04u3RZIkIoP743Krskx5im9vQ2mGW9RjknBfpr7A0Xs0X+7X9yRmFPROfG6f8W36GGJLjW0B7WnB/x79+kWVgL0bb+A+BVlQdu4RNJidYg1cKQm6+P7wqxTBX9zJ77G6DV+TYiIRP6vTTwzvm/qizTmX+aRlCz2MkfNZxsi3OZF1ofJkM7PD15Fv9YJCssaGLx9fUeR75WjCdsWz7S0vR4xy1jrwjC/RwCQt4/VKwcI5ZkWBf9m6MeIizrdcUMimbGNrXLwPV0QqUEK2akRaY4LWFs2VU3JTIWfvDiHaxTv7Xw6ls6FGzGXAp2W+qySakTY4curVbVJJzmXz42JfhnfjUO4ockthxGDNG30w==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7578405c-4be1-4d21-95aa-08dc1cbea3af
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 09:27:10.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl1/901Y4isY3IvQi4Vl2eobdNSGpZtyaN1hbF4toEBJBVHwOY0L6MV9X93iTmeIQwaZfB4Wz1xQKVftA/hfjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1888
X-ALTERMIMEV2_out: done

Hi Greg,

On 23/01/2024 00:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 417 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.75-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.75-rc1 (b62718874a32) on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200 and k200lp boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

PS: I'll push a job for -rc2 today and will get the results tomorrow

-- 

Yann






