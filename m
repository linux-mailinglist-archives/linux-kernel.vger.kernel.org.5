Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17647BD9E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbjJILc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbjJILc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:32:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2052.outbound.protection.outlook.com [40.92.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638A9D;
        Mon,  9 Oct 2023 04:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khXOXNbfCHlMRvWRdF2QXR9Zzkl24bWDWjmsRnJMiRbxVyhpn0aZkuxh2CmHg3goV3NorIB5s8cS1JBUVbAL9w+TJvbNv20GGF2afz0dBLod69oCnmHjmAY36Aim4C+D7iuPvMOeGq6FOpW4uwuPsRiz5JE4F7AvfiM1P+a+1VXhN+y0icz6tKVROdMVZlzZqA6dKL9y6KeBLYXsZLUVpmlt0ZFQ58KNhDEvqKy5YTWq5aq5Krp2cmRMljBRHxhT8hbtQ1/cc/sHyQl1N8BEcupNFfVXh4Xsvz1DjdzfjeN++YfQWqWoSJg+rj8mVWimoHjbU1vu3eSxsOs5D2rW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKGvNJOh8VmEhhVf9A1v8k86P0PMBv9zUocJ89PQrKc=;
 b=VIgLIjxAFEA1qxW1SmK/dxNHR07YmsNFIM4SNsKj7W90H45m3vpD0fOAAqk3g3nEh2CTxF4vvYsKzneFgJocXPi8lfGVspFbwnTEmO5nEDCcxi+PIYJip2AzUFb2Zz23fgUu5GirfjiLy5xX03wXWodQ67b9DIWgHuc9vkZbU6cW2+YZC84uUaGaQzcp5kvrDxfbf04BzphDbxJ3Ui1i11sjMB39g7k2Ftcf+II/pLcRDjBq5OUDwCZ2e23+vnD/2x9L75iWqkyYv76YngJZMgjSAPfariEX9vR8jmBc2zD6FxwVsiTQLMSNi7MaCFg4l+pftMkMekf3UUCfZCTjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKGvNJOh8VmEhhVf9A1v8k86P0PMBv9zUocJ89PQrKc=;
 b=f8RzG/kMZ00sXhw+fFQ2mFIoLEmJ1fGOObsNLz7mT9IeY3aZTDVERCP84E2MfvRX2mLhJE6CkYCZyie88V0/ekKEWdI+hLpNjg6K899SHQhR1NM6AZbHAfhGaiHeoMqbEMvVbqcFj+caqB8L7cgr5FaLz1dHaAtGv564MZgmnDYYunCmaJwjMKPCBi4JF4oV3tRjhkeRRw/JFIMKDS887h6DVEcoZqFpQxU5u4OU4G3jj5/nVoQRcH/np7e8ZwUd/JNYgHomZWFO8pOKVcHcczTt8CfzdXb8yeTlvudPts/ag9VPL1Lxo5YGi+xeriXHeHY7KSIy5vFNlUec/nAS8w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5782.namprd20.prod.outlook.com (2603:10b6:510:269::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 11:32:23 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 11:32:23 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] riscv: dts: sophgo: add initial CV1812H SoC device tree
Date:   Mon,  9 Oct 2023 19:32:02 +0800
Message-ID: <IA1PR20MB49538CBC1CD831FBE666A568BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <f1277686-2dd6-4f86-b249-0d9729e7ee6f@linaro.org>
References: <f1277686-2dd6-4f86-b249-0d9729e7ee6f@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Pza0iW39wD5ehD2aGdtQf7izfQEyXILtoQGsPUWUTCk=]
X-ClientProxiedBy: TYCPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:405::22)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231009113202.478068-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab860f2-97ec-48ad-a537-08dbc8bb67b8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQy6U68Yl45m8JOmrCpvOdfjPhPb50qPn51aIOlrNsSAwwLojTjZWRF4Am5TBypyoGp2v69gVXFsKEekj0U5PoyEk0HDfgQ59MqeLECHUcmbNHm3MR4imgXXxPM2FVIWUrmTG5+FEQ8zTh6ZxTnNrw3Uu84IVYTWFOteRq8xFK7IdfroKdcAHvTWxLW9Cwhhw60RUCGLtuDGUNEys0N8517Swa6K2VtBuYqUfPuPpPkYmHVEZou4tHUehonFPBJUrzrc98fOPqjEPX6isEIMpbGlbWqGBxasJ0H4Zt2A2SFPk04AJnJAVP04aR7yOg+XGUQiwLAaFihqmpNO4NFnvdovL6VY5tRqO1Osv9p67U94jTvF/XCUyDVQuC/KTL4uiJ1FmUMGUoGxXgyWMh1unBgN+2P2/JaB/if3IKBpzYlLS9B66Zh/oCZ+39DzcfTt60LrdzuPeVerbvhyIFidr3XpCRBpVmL0eyNcyBlheKkOWA4/Uw6L6GDCMNJsKhUCw6RIXRvYGeQXAtKWEQC42i0cCiRdE5au2BBDeU8jdR2if7CM/vXDom+PSPqol2dED8k/Qw9v+nk+d9vKoiaE0Vb4c5IQaCE3ykndMLINHHJbhV3wnxOdDrlxwePsfbzU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/m9n88c2mrcwYJ2cm5f1ddhKqWbtFcaDCEpwabnKoCq7RT6isrn9IM3Jb9zx?=
 =?us-ascii?Q?rzniIjFpXryNzoxqiHVSGf+FWXZlWQHKXtBsqsCNOT3bjB1IFHUGcvX97xYi?=
 =?us-ascii?Q?rBihRZocdbCF329kgbiYbQf+W4JtrADE9ajFqEXVWDCr+wdvJyCzPXYpi3O+?=
 =?us-ascii?Q?3Rs286TuBOcxD3DmnInpjjEDY86M4dtJnOzHZQleO2dr0HVLuKH6S6CfvaW1?=
 =?us-ascii?Q?aB7wKBV1IPfVoYF3O+pOqRDatbsQKivsZqaOYDx1FRjVHb3e6Ox4BeND45UN?=
 =?us-ascii?Q?MbguOH3xRFxLXhGnmCW4pUkFkCFCy+7Na8si/tE9J5VRXEdlrxgl7s3xbu/A?=
 =?us-ascii?Q?E1nUkRY3CVsl9ZJ89KZVocic6gkio6QrINuA2Gf+UQM7KbfjZUArJwxJNAqa?=
 =?us-ascii?Q?N28uQ8jCunTcFNZil1qYpYYlOVCeXwkBsbZh6lgom8E5ALYnqnFed7el2B4Y?=
 =?us-ascii?Q?a2HfZYl69ReEcrMhX03y0cCvUJB950BUtU4HHhEbUTQqM6YlGKb5quuECnax?=
 =?us-ascii?Q?ayFRLagyjmx+9b9OcfUVkBZa2uqUU/GSnNo5+wDPMEr+j9Y/eRiX7SGk1Dic?=
 =?us-ascii?Q?JtBfugs/JgJFoiTnol6mmEpOTnsyRnl9D5QXYsOYlk9N1zelCFDz9lv8A7jM?=
 =?us-ascii?Q?M6np9pi14Qz/WP9XhCFiML0saFd66yrnGhg1P2Tqkg5/OBoy90c+mlAk6icQ?=
 =?us-ascii?Q?n7n0OfvWxu/neNNrWdRPD2Nxu1g9odwtzVzs9txOUWUHlk+i7ZWwM7yzjTRE?=
 =?us-ascii?Q?iIuNvGrVGVm+6ny3vBasrCWdfZT3DaK3+z7XWZNrfAoHDdwEx3duvAP2fqov?=
 =?us-ascii?Q?oMZAXkVcf4fl4nS84PlwsJIe+Gv+IzNAZwY5oye4biyTToaCB/JbVl+Xa3RB?=
 =?us-ascii?Q?VASvA7rdDMN/KAG8I/yXLbps1Ykeli/mEE8lGZDt48Cplip4eOVQ1fTpDc1t?=
 =?us-ascii?Q?AlM1erKKnddaPoDOJuQzsEtc59gIkCYsYDU9rWe04StrS3TFRdHicb2OuGL2?=
 =?us-ascii?Q?GGbVFWFo7YGdkQAuBgBS9TlHrCPl46kTRZ4HD/4qPPa5NAyAGJkkNg4NPodb?=
 =?us-ascii?Q?LqRn01lu8mXkasFVA0KDDMrBr7cVyY6qR4Fvr8WiZ7Z8UtfQ2DHui0nUNv73?=
 =?us-ascii?Q?p6FoS45WXHA1aimKTRoFDvcOcMQaBhBMxEi+21VW9ViX9To+IU0Viz+Ad+D5?=
 =?us-ascii?Q?arUw4lWkEFPL97I0IhJGdusXiZXnZ+NrIN9V3bpizoV8U6l93QFIAqwB65k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab860f2-97ec-48ad-a537-08dbc8bb67b8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:32:23.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5782
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 08/10/2023 13:16, Inochi Amaoto wrote:
>> Add initial device tree for the CV1812H RISC-V SoC by SOPHGO.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi |  95 +------------
>>  arch/riscv/boot/dts/sophgo/cv180x.dtsi  | 178 ++++++++++++++++++++++++
>>  arch/riscv/boot/dts/sophgo/cv1812h.dtsi |  36 +++++
>
>You need to split moving existing code into common file and then send it
>with proper -M/-B/-C argument so the move/copy will be detected.
>
>Best regards,
>Krzysztof
>

Thanks for reminding me. It seems only -C work for this.
