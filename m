Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C38041CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjLDWpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjLDWpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:45:15 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE79B;
        Mon,  4 Dec 2023 14:45:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2GcGVTUy7Rran3MeffMBZv65/ddAXBN6AnwpEaZt4axT2xKph6Pjk+ujKo2xWrs5p33vPaVOSl+ruSLrrHDExylxsXMh2hC57cK+wLqnLasSlnnOMQIBL3jjHONkR8QLCzT4EjKv6fMbRpvoaQg/eJ0FMBxxIWzVYecy1gPr3uPMmXIxcBbR1kj565CAm5U+13iubixEtXmpWlqs5JiolNYUPNQlnjz1Tus2+dGTSlPb4NED5RehAba55j/ppvX0oarPjolxsbQkePUha709RGKVJ+wHiCUB6En7p8ERbe0KUeXeYvdLoDHehoSFQCxb9I5tpWM0LM/TGEV8UqTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhCVamRV+53hLBG1mG3wlCOZF33LLPkV09hqn+QHwZo=;
 b=EowWszPyn/PK4yRBwNWQI1z10JvS4Sdrat2X3btIEnO4sLECymX03V0yeI91TT6ioPcgc+kis8mvQahUsmhlMmgiEa0KRFztjjmdxLFWNyoTnlNXX8wQ6nZ3hev9YItnXzJxG8QiXydNlukRpat8SUMr4IxM74u9uhyrkHlpW68izqFESsfmuibxpjveicR4mIuTXFcGLEcjy9Xst2nPq0EPe5NRHr316VlHUeysvdJKQ4rPZrqUFsixt9Djeo/+2ZiDmRWtOKOWONWkl7Lhm/OONIxutRkucqOu2M/vhiaB5J05B+plcsy4hIApUQoDd0v+PA47rxpiZ+E0Jsk8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhCVamRV+53hLBG1mG3wlCOZF33LLPkV09hqn+QHwZo=;
 b=oX/eDsKkt12YkFzOoBiKKdJKr0AChbsVcc0Vd/LXzdr0nSo0v9niRZgtQRAG2Yxww2njvkIfc1ooVYEWm0xVnePJGnY5vJf4G/z8XN1rUEDFMj6UsYgds3SsOQyWf4ri+9FXFd6eVLiUP4FpBDERCTd+3/OO66bhIqHaMSDggLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SN7PR01MB8116.prod.exchangelabs.com (2603:10b6:806:357::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Mon, 4 Dec 2023 22:45:17 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 22:45:16 +0000
Date:   Mon, 4 Dec 2023 14:44:54 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Ian Rogers <irogers@google.com>
cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
In-Reply-To: <20231204182330.654255-1-irogers@google.com>
Message-ID: <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
References: <20231204182330.654255-1-irogers@google.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:610:38::35) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SN7PR01MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 916ec6fa-26e3-4e0c-3f7f-08dbf51aaf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3//THX1Zgk6QKSWh2GqWNgZalVbJWOVRArFboXjrImrbA5qMKZGoIomYM0QcDHxN4ZcZAJX9uEMbamyFZE47rvhVUpvHOOcsI6U5Rc4PSKvMFNlpCTs718ggqM53qcZ8thDTGJYGbFUUoLnZrRQ80H8cCfGX6yj4fh88gG6G0BsD2qpi26qDFawQYCwVSUqu78jQc21Q7x0EcxmksyXVohuyTG2Uj43ZA/0ZoAlzilaDCyuoBjP41iJrsTExkwoywYvEOYuLgz7r3p25zD2XfNZLzaSCLWOoLSFLf8V1hw51yOliay1kox5FzNlNoaMHjzC4768fMff9F9lCxCqPiFaprAI7E1a4hIu9lVUq+vtO7QQXKqXQLKXe9UHPdeqve53L43dGZBGugEuzbHrztLf168oYqzBl5sf9v6nD9TVALt3vzWAznhgXXCPoxE0CucFCq0osSN/gD6OPmpvxsA4bJbxOMGmho2cu++47eQhcGVdC4PRwV1lgFQQWmJKwkYLMUhRy3BSNHG6e71SHxFzpKg5vwGZMyvilQppA8knL7JFT2S7fXIkfkxniJ1TsI0bRY31W2Zvj031bpnN2Otsd11KzfPQNtpnUwrrNPt9TBed3jcLlwxU0Lsle/iB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39850400004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(478600001)(6486002)(83380400001)(52116002)(6666004)(6506007)(6512007)(2616005)(316002)(66476007)(6916009)(54906003)(66946007)(66556008)(31686004)(38100700002)(5660300002)(4326008)(86362001)(2906002)(8936002)(8676002)(7416002)(31696002)(38350700005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K7HtSOay6ufLi8ZoKldM/bPHuFLucsugpcSfmV2M6EP+l0sm7mUqYPRPIBXi?=
 =?us-ascii?Q?ER7E/Zg8oF9EABRG4cjFOsYkQE2CwIkWgN/4UfN5GMpGOAyhxLnqs+bjrq4A?=
 =?us-ascii?Q?5q/i/9baoSVh5PG0dXQVmnvZ5MZGmUdMBoedR8hCk1Hf9CbbQWBE9zGTJv0z?=
 =?us-ascii?Q?dTeVXDDmP6A32ntyVSbCBPZAdL7qsMYsNEj6g/0uWyxOhHViW1gBMhnr1+rI?=
 =?us-ascii?Q?mUJvfHlO7xkUL+UKNfwGLk1YCCacr4UPFi/ybp2Uocf4653jj8e8niYRQiqE?=
 =?us-ascii?Q?G9dH7tlZKw4IMMnQmD9OYkM4keKWfbLy/a+hE9Ei8BAWklO2x0PWr5DVL5tL?=
 =?us-ascii?Q?HBhGaW6As+mu1FRph8gVst8lsxP+8+1Kf7fzAktHHclNFBc3fZxWScJTMf7d?=
 =?us-ascii?Q?Dk8MPURh15uZHwWTPXmD6OujcvSY0LuqN9wiSJBttISs8XblsIyNqamdZ0EJ?=
 =?us-ascii?Q?pdQW7VL3Og4V2fYs6QBpPjFKPUtPBv0mwX8Rtv+ih21tus0uUzM8ccCw4tRG?=
 =?us-ascii?Q?PCY1zSo3z6k9Ys4Jb3BO2gwZzj3nBsoBvQMRcLJ2TeSJldfGZFF/FWiGKXmP?=
 =?us-ascii?Q?5mSU9S06M36Kx22B1PMhmT8G853Cr+NfQtpvriDXFbElih1snz04iVMsy2cs?=
 =?us-ascii?Q?fyEVbv/0rz0+/I1WicJsKJjFmZhg+MtRas7NZSiTKd3pmu2CypOqgZLP2VVk?=
 =?us-ascii?Q?VoIr2zq+2h4whrUxmfoMUZ+DspcMKLWJJ1NChH+FgjISFM2NOCR3p1f7/e43?=
 =?us-ascii?Q?MzxAOH0GnoUR2otOwlNPLqFgH6xjymL83ccP+1MonwYTO/lGjsXLgiCGxEVV?=
 =?us-ascii?Q?e7RxuIoyqLgol1aB3E47x3JsACQwjaOCHDnjFOCWdCVMhr0Mig+v9/ZxyQwR?=
 =?us-ascii?Q?O4IX8PlqeZsD7j2xJR/rpFmlvhOyWvNlQjLH1QWXDPPQbdinfCPJLF6SjCQH?=
 =?us-ascii?Q?X2my4LoGMlSzZPt3rVTt15LBRFu66ZgdoNbCGntG7ryYnV93+9swmfMY6ChB?=
 =?us-ascii?Q?NmBut6pRmQTNxt1Qkhv0LFLy2cBLqUF5e27J+LNJPw4vS1DYtk0Cg/bHqLC6?=
 =?us-ascii?Q?CxRYTl4/rEDYYcLIaZpSA8GGpbSh1osej5BrJ+fDDJNbNhSmjeYYayNZ3gUT?=
 =?us-ascii?Q?/bgpjy+3m6neICtKB7s9VPONbRATgWcg2shqiqvzt/TbaAoB2yAtfUGc1Leo?=
 =?us-ascii?Q?NSCqdG04ocuPNKh/9jPiIgPpD4bKeeAdneazDlAgFz7Sx9kC+9q5XUUvaJ+o?=
 =?us-ascii?Q?tbW9L0xBD0gPuHNE7ntnC7GZ4S7+VdECziIGjkRVrv7og+PZFSUDSEnpLsQF?=
 =?us-ascii?Q?bYtX29MDP1P4j3dR07xGMiK3JJ3tFslWvCNj/s5qJSUnzIt9YYEXPZksjHg7?=
 =?us-ascii?Q?8GpHyNvgLo+wNTDZb6mO0LafySViuXahLpDxc+eeK7WWmHWliVllD/HU8562?=
 =?us-ascii?Q?YEFevZfq+WXKFuGFtkfGLYgSyClvUxYzBW7zRUfpIxu0RQ1SNwLKx01Yh4+h?=
 =?us-ascii?Q?/vLVd/oORDBYaoXGFOcyISzqc1rDzqEyTYW8OyBNn9MI7gjEq4quksdTCibB?=
 =?us-ascii?Q?G/fDd3xqLMFXpFtLfp9vNClh9tEd6w6xom1QQU6C0vdaZZEy8TNwgJilVZ3D?=
 =?us-ascii?Q?7QoFmipYQIuU4uHIqtmWeZQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916ec6fa-26e3-4e0c-3f7f-08dbf51aaf8a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:45:16.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph4yiv1lpWugDtHbFC2cIf97z9yqrG0mY6K86dR9COnlPz+4uLZv0ICotFxdmo0QODfx+evmE6p/ChQW4ni7Onb29cA0XiK8AAXLvWHuMmVQSmHpAsr0NN88QLyC6sjd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2023, Ian Rogers wrote:
> A metric is default by having "Default" within its groups. The default
> metricgroup name needn't be set and this can result in segv in
> default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> that assume it has a value when there is a Default metric group. To
> avoid the segv initialize the value to "".
>
> Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks! I was going to look for the bug but got pulled to other 
tasks. The patch looks good to me and I tested it successfully on 
AmpereOne.

   Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


Cheers, Ilkka

> ---
> tools/perf/util/metricgroup.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 0484736d9fe4..ca3e0404f187 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -225,7 +225,7 @@ static struct metric *metric__new(const struct pmu_metric *pm,
>
> 	m->pmu = pm->pmu ?: "cpu";
> 	m->metric_name = pm->metric_name;
> -	m->default_metricgroup_name = pm->default_metricgroup_name;
> +	m->default_metricgroup_name = pm->default_metricgroup_name ?: "";
> 	m->modifier = NULL;
> 	if (modifier) {
> 		m->modifier = strdup(modifier);
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
>
>
