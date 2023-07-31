Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9B2769AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGaPlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGaPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:41:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE25D8;
        Mon, 31 Jul 2023 08:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFf3FhthXuPZlsgJCmoQYipH+1kTVJ6ZekFe/H4U9yHZ+95uo4epMBIKMUcTasoNrzqL/VnHp6qqdHr4HeJp9892npyp5/sWOnaiSE2JjRUHWbfaGTci5r7FWnGiy5yQf3nX1uRlWRSsztoyh8LrtMAfCJD5U89iWFO9q3X10Ym+waLs/p+5L45IGw750R+8eK7YQImZdGUt6a0t8Lj5dyPsELtMjDxdk5SukMn//h7Xv3FaZBxmGXZoYsQEKOPBPH/nqwYBpOS4vztr1RW3wwv27eGFMueuNUqO0UQdzR0A0sksRcHlNHn22XbCImEEvY2S0yBykYz4UghZiFUiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+PP0PG12C2rIxwVyEgELOmKu7XhgeVl22umOi6fndg=;
 b=Fkz85cSYzJhuPs/1Dbp/J4Zv1lHu+f/0Je7cveGgeofKqQDJaHb45RE/H8oZ41oAGBouEMhBijAEIb8B54TnIxFedz19WWUd2mHXd3/XnGTj8Dgly4zPhtEbvvFPkHoL74CnmD5saiY96EJiVrIvVwdCsZvrtWwLFigwZ09ynK9aEV+h/JLAOOa7udPdSLSnxNwYcqRKCNi4F/dXzlmMLVp6zVt5KKuHQeB0tqDOA80vpGvYnrlC+dCshr7Ho508Spfl+PNLBcKbVe05MivScLDy6LX1Ej/j+bfoSFYBrQoQqq4703pBc8eCzbQwCAkczfLRP9dn5c4n/8ab2rXCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+PP0PG12C2rIxwVyEgELOmKu7XhgeVl22umOi6fndg=;
 b=s0NM43USLd0KPxV174hp6rTStrmSLoGLpOXC7NKul1APyt/m5AiNABEr4QivjbaCAO8F4TSInHfGjTJuuytmAHRLNdIAHjhY/YyaBDIckmc0VNoFrsuMvHqXvylBHJqDCql9PQgt7B7lRO3DihqzM9I05QYjBso2GoiNP7EulqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CH0PR08MB6843.namprd08.prod.outlook.com
 (2603:10b6:610:c1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 15:41:14 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::3330:a9d7:a566:68b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::3330:a9d7:a566:68b2%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 15:41:14 +0000
Date:   Mon, 31 Jul 2023 10:41:07 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 03/22] Input: iqs269a - use device core to create
 driver-specific device attributes
Message-ID: <ZMfWE3HFwpiJx5yI@nixie71>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729005133.1095051-3-dmitry.torokhov@gmail.com>
X-ClientProxiedBy: SN4PR0501CA0116.namprd05.prod.outlook.com
 (2603:10b6:803:42::33) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CH0PR08MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eafbc1d-34bc-4ebd-b30b-08db91dc92a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqKfb2CqLHTdFlz0MzKHhZdORY0oRTvWWf7RHsfcGj9QLI40sAyl0cUcrlOXrPlrjND6Vvx7aB6I+AuDFrXnvMVTPj8JYZiD5H8/eMbqgmo2UCVvT7bmmMSDJlhX6kWf72Phvokq2CCe7KisRKhIO8M7mrpGiOPc/1wvV96qc0d6ldVNy0TnhqwXgQ7xZdlSwyMbBkzmrzIpzi3VXAEQExMVnQy+cLoIOIEtWRX+ty5L/yuqy14Sn8hbhrrlb97kbhKGBaCPQy4J4dUpsOoZAnAyUzkxHXNxzOlEawLarv1o3XSSEsqRvt5nkv/J+Dmssi9/HGFVJFLDJmxI4b1gdwiFIA5lKYEa2p7tGwtsSeEXZQoLMKCdS5OmzbnGFvpQQjJHEzf7z1MFGAZimEsXf5JPCv9k0PAt+IEjyurarKg5Ol2OjKDgQSZGw35B/r90l2PPwoEKLsJ+Q6nqPkhTdpN3iivNPhI5Qa861KV0jb4Sppul8UgucQW7cOeix4r3fcqXMQbVw92oSxEBt82IZlap/z7mthpTqa44PSZTLD+OTgHfIQWgCFj56uvA8VHl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(376002)(346002)(396003)(136003)(366004)(451199021)(66476007)(86362001)(8676002)(8936002)(316002)(4326008)(5660300002)(6916009)(54906003)(33716001)(41300700001)(66556008)(66946007)(38100700002)(478600001)(2906002)(6666004)(6512007)(9686003)(6486002)(6506007)(26005)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w8FlFCsTRht7AaWQn2sc3RlZ7D00ktbFNmC/cOeVQCBBm17J8ODO/U7wMlmh?=
 =?us-ascii?Q?VxF9zMcev2kLTdNmelU2UMMrd8Fs4Qci7aiZ2NrFzC/Gxcf2o67nUBf1EKsp?=
 =?us-ascii?Q?y/YWJFcMgcORq/ziGL+ViVhpnU8DKn0caANYxlYnDvjUUybpEA+iwZdCDcHE?=
 =?us-ascii?Q?DrmsBVA0qeLOCIOajo62mOTZ5X2BkHDxDMz+q/23KMfWc3r1I64ShbQa56qU?=
 =?us-ascii?Q?W10dRO9VxcWeKVEnS+VWF9DHtOEycBRpkT+0bVWfh16R9ULydge+Hm4SISVi?=
 =?us-ascii?Q?vO7ef6g4FR2UubKykF+AuTHDxBSLzn59aw1GhqPH+5ZKCSeGMmF8ZHclUgWc?=
 =?us-ascii?Q?6DhaBoqjL46ZW5cq0q4IQCn7zfVHav3Ii7TsETDYeL12KjEoDI1qCqgpJBQx?=
 =?us-ascii?Q?/EulDSU0HlLTh2j84HxeogUbYzT8PPRqneWhklIWYteNWEFE6p2QjK61RPLN?=
 =?us-ascii?Q?7pELNwD2hlK7M1icR4XWmfdVwhkjjdhsJfN5IAawd6fKwyrdcAMmwiN1rc53?=
 =?us-ascii?Q?mwOscqs2QSewbwKkTnY7nT57eLDWbZsactv1xLURlPUcyziAZAgYUt8Ew+fN?=
 =?us-ascii?Q?k8LRwn9hAj1YXFqN0RESJwzCM5ABF56MbM3aHxC7cP7XhrORnTEr6H5th+8O?=
 =?us-ascii?Q?e2SLeVbgSl/hr6kuCMbHosx6UowKbdUx8hDQPM9XQA0bsi93KUG8Qk8Pz4aU?=
 =?us-ascii?Q?O2GtHXI6merHa+a8umuD5Y7/eckl1dOkT3CKaslq04226MpSG9wCHPzBMoFF?=
 =?us-ascii?Q?pGxGyHI5Cx5YjMpf1mvSs0ASthHXroeHImJLNcw5+/DJv3RYZKqENdLbTd9Y?=
 =?us-ascii?Q?aPui6dP4BSnmTK1XC9e3KJFgndiZ+GoThHj7OiUzMHmxj6mv+dR/ERroGgNA?=
 =?us-ascii?Q?Q63MlRBlnI+q5zo4+GRIOazXBuiRDVoJ2vFe3UxFe2aR75d6nJ1A/XA9glps?=
 =?us-ascii?Q?LS4D0YhXrhT1tR6efkPjz5mX1hRDOuaqplzPIcznQl0LkrbSIANHBvDlkYky?=
 =?us-ascii?Q?z//SvIOeSLUPYb/4JqEelzzZS4M+WgOzDQLsNO8UrASlQ+gq7iwCbph9qWJn?=
 =?us-ascii?Q?+qVNVeRN6w6CMUrw70AfFWdXv/HA1xu7zJiCgfBLSok6fgNltmTl1tjXZnQr?=
 =?us-ascii?Q?OxBWcbmfJ9nXkIa/ZD6blJIjTwGT0TiFi3jQecFvFJ4Urp69tuV6n1tKpjZ1?=
 =?us-ascii?Q?H5fXCMUvCRdXZXNc82wzfSUP4BcWFlp5K0332riFkhJQ74fXF76HDjP/Efp6?=
 =?us-ascii?Q?mnudYjnl6YL2x/hkUQxpkMyzlLldUbXhtEaNoB7+IFBfy9/wo7JhR+TVZ/oA?=
 =?us-ascii?Q?EIkLuI7QUgZ3Kbk8VI7j+7ac0G21fLZ5eCf2xAD9fhsuDqlYdogrprLNu+Za?=
 =?us-ascii?Q?4+bQH8CsEMAq8FcOnI18nzyf9w+lrrMEnanqrcr+EriytvBrMEWd5ThfwkN3?=
 =?us-ascii?Q?QudKo7+Qi+j38B6tg1t7VnK+GBjkdV4EsBqopR4IsJasf+wvkdjjKmqerUR2?=
 =?us-ascii?Q?w7q0DWtfzKFEWJDtQvvDL1ynW3j1vHu3agLU0kJ8D3v8s8P4ZkRo4ElrTu4V?=
 =?us-ascii?Q?8vKK6SBzwoTiBp+wAfjwb9Cos6hnEFCRZjUzW/HU?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eafbc1d-34bc-4ebd-b30b-08db91dc92a8
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:41:14.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1bSbsvKlyyBZvjjCsGT5LkxyMJ/cEGV8BrXcEO+6ERN74Sm/TklvS3n2i1eeJjIgFdKgo2pgXh9EYmDj7ShAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB6843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:51:12PM -0700, Dmitry Torokhov wrote:
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

> ---
>  drivers/input/misc/iqs269a.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
> index c0a085639870..3c636c75e8a1 100644
> --- a/drivers/input/misc/iqs269a.c
> +++ b/drivers/input/misc/iqs269a.c
> @@ -1586,10 +1586,7 @@ static struct attribute *iqs269_attrs[] = {
>  	&dev_attr_ati_trigger.attr,
>  	NULL,
>  };
> -
> -static const struct attribute_group iqs269_attr_group = {
> -	.attrs = iqs269_attrs,
> -};
> +ATTRIBUTE_GROUPS(iqs269);
>  
>  static const struct regmap_config iqs269_regmap_config = {
>  	.reg_bits = 8,
> @@ -1671,10 +1668,6 @@ static int iqs269_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> -	error = devm_device_add_group(&client->dev, &iqs269_attr_group);
> -	if (error)
> -		dev_err(&client->dev, "Failed to add attributes: %d\n", error);
> -
>  	return error;
>  }
>  
> @@ -1743,6 +1736,7 @@ MODULE_DEVICE_TABLE(of, iqs269_of_match);
>  static struct i2c_driver iqs269_i2c_driver = {
>  	.driver = {
>  		.name = "iqs269a",
> +		.dev_groups = iqs269_groups,
>  		.of_match_table = iqs269_of_match,
>  		.pm = pm_sleep_ptr(&iqs269_pm),
>  	},
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
