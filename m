Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E7A7E6A36
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjKIMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjKIMBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:01:36 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9612102;
        Thu,  9 Nov 2023 04:01:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABznZXwPPOTKssBzQ9YewdKbeOaQzPnkKuGdhyQJdFhF0u5cISTcE7yPB0T0eecOdXL81iAddnIJDpNl6dTNhdPkQsahb30Glfi9SoiAb+UqY6XUeDEmfz9+Gy6j0d2zhxFnXRYhdLD0Op7jY5HEQG9LwYZLX8+/Ucuk1Q95jOb5eE1Qexfc9wmPKG+GneBfzV/lDG9r3bagE0UfCFpvVSnuGwtwFWez5fnzOUlF0RsBkxzkMVGantN9dbnpjbNm6CNhB96Pyn56G47Kl8gIGI6KraJn8ZhN3nPPxbz9S3mqaDBm4ZYPQdxTx1JIpbEkdNZDdcNqFN+PiYLNjqUh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoIsXpCOhjyy1Pq1jKs4CyOChMqg84s9YLkpMkC6dCM=;
 b=kK8HDK6FkuMckP/fJj2m9QhyDnttNxheuKL1buBkU3Ha1T65wik5y9cr0ZBxk/USx3hQX/2RbN+tR1tqlWyOivI55fMTB0i8ObMXLY1ZxFu3UVF20GOrltzRT2SH1FNQ2MhSIUR4hJVVsXNNjHAmWiAKG9SNL+8isak42judqYE4ovqqh0F7C+KlTy5tCZUhyeWPxNzNJ9O6/q0r2M8yHe3w1gKD/Mp8ZU+XLCQR+qwpQNDMSfIfHaESumhrTwaPcNy46u68HBOIHJOYO9KwMV78hgw6+bWc+x0iay/r/x+rOb+HyOq0uHBX0eT1IToseB4A1nEYPxb2zIE7a1DGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoIsXpCOhjyy1Pq1jKs4CyOChMqg84s9YLkpMkC6dCM=;
 b=kf7qqfBmZQi5MUsQHLNWd5UVwky9aV8aYiEh5BPbutoWg1A3dopRFfHb4pIoggqZgWGfo5Ak6Q83RPfbS9EYwSRZot1mSU2pMynLQy0oGbwH1EAceNFLbgnSQR4oLc3Nf+U7xhJ7A6EDW6P+0c6N4i3U0dCZErI5wS7/olG5w3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 12:01:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Thu, 9 Nov 2023
 12:01:30 +0000
Date:   Thu, 9 Nov 2023 14:01:26 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of
 cycle_time and interval
Message-ID: <20231109120126.75vxgrcdjusfr54y@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR0502CA0021.eurprd05.prod.outlook.com
 (2603:10a6:803:1::34) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b1f746-d527-4b33-ae38-08dbe11b9bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOlgdfz7fVzMNsqBJRCuxOrsn8AZchnK90HjgOXtU2i/ez4aYslo8dc4yNIR25SbX849rjyMRumFzc2OHZCQr/V/BJXKaJOKXY0YlHBoEfJQgpkPce37nIYtyb9ptEwJNVcR3K3syrkpkPQCiddusFJwOTLXPWmmWz195O6CqwVx3gnCwRSnK02nKyIeByS8xDQjakUm5ViLM3yLa0CTW06+W82EHOpgpT7EWbL66KKRDvIuAdpmxXiuqlRnrHxeoCoJzHED82x/KMTWibQ7icYUmBhzIrahOQamzwxbIAL5pZvYHywvruU/FgmujOw8IgHgzKm5pcpSHEpMYcagRqTkBKg1IFyJQeVXyLI67gebBeteckuaUaKwIZQI350f6a2lrCCkqB7J1PnO0teHzaAwmwqk7Jvu8DMu0sIYij0nHbWaOsXI/a6QuY3DA6Zme4NJiS6TKlYhhQ+Tujzo7GI+WGHFZjBnoG0p+WTDH548RulrxmDdUwWqIkyByHqvw7cYa/gHeKnX4GHaW3GyxM05i1FJOdJdi1/ekoAWHS6hFTI1xb8SNq1OInXC8jrm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6666004)(6506007)(83380400001)(38100700002)(6512007)(9686003)(1076003)(41300700001)(86362001)(8676002)(2906002)(8936002)(4744005)(4326008)(5660300002)(44832011)(478600001)(54906003)(6916009)(66556008)(66476007)(7416002)(66946007)(316002)(26005)(6486002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxWiwEKLfsZ7PLfPnJ98plp7tRSeydenTOkI754CGxsmTs7OZXSIaAvlowuQ?=
 =?us-ascii?Q?aG5mxbkDn6g3pUeBjAKBinMF0jwXoVC4tdbwr3aQiRNpwSc0crIFQshtV1rI?=
 =?us-ascii?Q?DNiCzp6LzdWVWKh2/At1VDoPmxgVncEaU1AQtxgAOKZB7QodwzFORJ1w6KSG?=
 =?us-ascii?Q?Xn6UE5QcdQ3+nl9HjDZ4hWNywU5uVDNLDrpaQTUc/G7xYYNiM5rldk6T3Of0?=
 =?us-ascii?Q?kr3kFOpMVX58dY4KGjZ40g5U3w1SccwC0GhPtpEImgYMpBz0OV3IYeNj7YDu?=
 =?us-ascii?Q?ZYj0ZDVCyXRNxz1mpyDdYc6pHG7spFbWiq/S0XTx9kkIPlcZ3BEVOIVgPx36?=
 =?us-ascii?Q?gvuf6L3EQIcquw4sRiw8FSMV6kbBlzzifKZc6biUf3Dy6Sr8C12bqc1Qhkrs?=
 =?us-ascii?Q?lPFXWsKH5gOeKPZcJxMemIDBNO/raV+dmPE5I0TzE1vhlaOEx81rs8iplQ7J?=
 =?us-ascii?Q?feooFkomVTMgPMvUqdF0YAIx8ypu8376GyGoZ38PwEDfNQoNdkxKos0jDUNY?=
 =?us-ascii?Q?b64ivNodC7A7rpGi3KhuVFwNaXTNxnJc3jDMoxBKS7GX+5SG9w/jFijIqfY1?=
 =?us-ascii?Q?I5qeAX/h1TDwVKrTLcvzZtOk9Mcv3AYtUsh+9TG3uMgKtocC5XAMIXSG+VCY?=
 =?us-ascii?Q?HPY6DrJv3sCbrI1JmhCCHIuwGlh+0rLg1K6aWLXYoy/yMoVs+x/hQUWiUEFD?=
 =?us-ascii?Q?bEjSx8ZowiSszQ6+g69rU/KpVPci/zCw1coXQ967BUMoLFLH916gMfwBGGXs?=
 =?us-ascii?Q?OxSj4vAr8IhUkqOFCbkzhVRYlHHlb4aZE2Toa347mBCz2IsFbLa+7Gxv1oiZ?=
 =?us-ascii?Q?64qCJWaV/1fcoaPEY1hrNQWpvboLzZDy8AxAfoIKFXiQ5nV4dqjSWWboiji1?=
 =?us-ascii?Q?Con9IbUbc6vqtcUYy6j5Om1wQTPbQQXswgZo8OFI/F7XdL622VD6WwD8VkQA?=
 =?us-ascii?Q?5HSIy/m3hi4uuOAJw6cJl/qrYsFKbnMkGioDI8nIH02hR1wtOEp+V4iKgE06?=
 =?us-ascii?Q?EHQ+Gspfvdci0m/5em2RDE3iq76U6oayvwNg6RrDZTTltel+d6JRTqgEzKxR?=
 =?us-ascii?Q?faaqkeD0LH+A+AEVPOXQLZsbiDZ/+Lmcra/pxNv26jMlcNGFXtVw5PpGujzS?=
 =?us-ascii?Q?/cLT6aLhW6ahsOyNQHtaciGfovHl82JG62Knvn9ZtJW4b0MFBB8aoJ85ZfZ/?=
 =?us-ascii?Q?/vBUn44ijFndhCS+2cF4v2mP4q4kuvmYEFejizlEiXboQTtoaWwrm019gEjf?=
 =?us-ascii?Q?24L8WBlHR/uU/+oUu+JIImcoE1CJnmtDuhvMTb3U31YWP5rkIOtQ5ey2kwHr?=
 =?us-ascii?Q?4CsPj3NLynzdrtXAo6GpxYMu5OXTzLjL+wqD14YGn5bFO9iSJ4GQdy2NjNeV?=
 =?us-ascii?Q?21NQKjc2Ug8aDThWK9pdt1CiEo7Y78QbMEbsJ/8dOnMleKUwEulKtpkcoVUm?=
 =?us-ascii?Q?QwseLCpM6cbVR6aDFPdWTcepVZCMQdmf95SmSYE5x1ECiysEVQzdUeHG3hm9?=
 =?us-ascii?Q?B0DGqJvUR9HNn0Df9BHkKbZ/NwM0RMaUFU7xYOJXo4s5U2BjB6vvLgHEH9Pl?=
 =?us-ascii?Q?vEB52RlBx7RCVvQ+91knQFF/CDPlXinOtmR/6idN3t8HvXDJqOUTT7O1Gd2u?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b1f746-d527-4b33-ae38-08dbe11b9bf5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:01:30.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euEIf0+MOFf+liiIqF0unmqLt1pkvV3DsBq2mbB4ateCfwJ+TOx+sRrSd7L6cJlDt3IhERmZgW9IbJ7colHaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:20AM -0500, Faizal Rahim wrote:
> @@ -215,6 +216,31 @@ static void switch_schedules(struct taprio_sched *q,
>  	*admin = NULL;
>  }
>  
> +static bool cycle_corr_active(s64 cycle_time_correction)
> +{
> +	if (cycle_time_correction == INIT_CYCLE_TIME_CORRECTION)
> +		return false;
> +	else
> +		return true;
> +}
> @@ -259,14 +286,6 @@ static int duration_to_length(struct taprio_sched *q, u64 duration)
>  	return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
>  }
>  
> -static bool cycle_corr_active(s64 cycle_time_correction)
> -{
> -	if (cycle_time_correction == INIT_CYCLE_TIME_CORRECTION)
> -		return false;
> -	else
> -		return true;
> -}
> -

Don't move code around that you've introduced in earlier changes. Just
place it where it needs to be from the beginning.
