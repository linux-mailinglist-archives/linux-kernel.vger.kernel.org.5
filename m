Return-Path: <linux-kernel+bounces-148227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6403B8A7F95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E321F21AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E73130A77;
	Wed, 17 Apr 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YvEYS6Qk"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2047.outbound.protection.outlook.com [40.92.45.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721C12E1F7;
	Wed, 17 Apr 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345912; cv=fail; b=C83gQxuDlu/xFZVxa6sPIntAcTIrylFUizyMIjSDy5GBCWS8Oh8UUmHFcgKgEsaY1nSpRtwMklHF2OT/xq2R+DMJhBN0a5ludh2JssHtnkLfkO+OsWgYibroGr6QBHsuX/ULpFiWQEiu/UyPY91I5KlFP/rjHBmar990cPPdsr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345912; c=relaxed/simple;
	bh=3rY+nmLwRFrW41PbWCZrjVW98eb6eOpT33Wq5kyhWdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dMtNQ9B0xnV9w/7AxfZIfSYm0trz31UDBs6+HBwme6Yn9YfY2AeIvWNrKRryFU55Fx9La0u2zV63N3Wq9tQ9Wn1wBcRjgGZSQEHohp11Opg2OQ8VwqXLwC/lLA5tm/JWl9qWZakyguTcQK9ruTGf0naUnaBaHa9BLMj0hoTxHoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YvEYS6Qk; arc=fail smtp.client-ip=40.92.45.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvUIOeJzl5x9TJu6viLosRYDeg2g3flud8c2gK/WJSbNCJYas9+x/dcZy6mltNGD12XmYF/K3s2AcA+z20vkd1/Qenjx00TD3YmWNPlWJX6UQU3AN4QzhKaZD+R1wK0fknUKdw0Nz8Ag0izPK0G4RS2DbkpdnqtMgFW7cH1puCjjIHTfgVk4J3RSOSntZnazEGIrCBWjrCVL07aNg1T1QOl5dHuUSdgPkuBf8vGgXhrHVah+l5qDET2GGJCRpg1LOuPjYgpTq1GC7P9gzxvwbQcB+CAYdi0eWRqrJfjuWGje4EQu3aamx0TVZT8YilAsArWZLcxIw9OIb/ekmyg5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK0fPDXexyDQkrrbxwm0Hm2LfbNB8xvwWYYg6VER4jw=;
 b=G71s7WMKyMmQf4SYSAnwOqZRtFHtO8ShFj4RYBKzOZiWPHkgchmf06hlBhjwFTjpcHx0nv6AbzVW1D2TX+1fmdURN9cgqb02ETQqedAP/LI2WXXMd6VIARkPNNT9eGni6oM65QxLjfW1x+OyiqiWfbQTRmFWeWrar8bfVYNMgZTN3uK8nJSKEB5f756H/AJcKB40r3fiE4PaMC0VdQv8QJ2oClzopPOXGb7Nuv/5QSqQEx9eMYWUj3fR1Er8fLUcHyPEMA4XOkupbWEv0fEA30W3pKjpG9tZM9EnaDZEMHQyZsZnyphDcYOnV+zP0qLiUt6i8ornQCWWX28Y78jJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK0fPDXexyDQkrrbxwm0Hm2LfbNB8xvwWYYg6VER4jw=;
 b=YvEYS6QkZTpoTK91UqqI+UAUC1DNqxwjBwzl2yyAparGTgQ6TBOFqbCyC4EY3Npljq9xa1Lfin2QCGERuIg4eAQri/A0tCD3PX2tm1Wti/lMmQqCwbjYEx4YaMMvcVzw6fs5VCC7rXBjbQmCz7VdZ5Yo0DvUn/5CKtlkFW2abUCRGV3aHKBXl0akZcLI4UDciMGqRpOrSWMjwdRXNvSklbNkhFokCQ0Wxx5zBikpMKaxFY22tw+QxBRBz+/Ghgf+Nu+s2mnMtw3IeUZe7YuqjLkYSXH67yNqFsiQbBaK5+Vo6hblB7UPfxsaFBdrr2tc4vn2CV6bPOqga8hi+JFFZg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB4405.namprd20.prod.outlook.com (2603:10b6:303:16a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 17 Apr
 2024 09:25:08 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:25:08 +0000
Date: Wed, 17 Apr 2024 17:25:30 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: michael.opdenacker@bootlin.com, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: riscv: add Milk-V Duo S board
 compatibles
Message-ID:
 <IA1PR20MB495369EA230463E127F6FE8BBB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
 <20240417065311.3881023-2-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417065311.3881023-2-michael.opdenacker@bootlin.com>
X-TMN: [DS2hbVEE/lzbCAmXxx4BhfBcTtpZu2wO/hSuf9onzqY=]
X-ClientProxiedBy: PS1PR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:803:3d::24) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <rleld4kjazh5q6wffv4gflolmxjihqdushkonn7hgcl7dps2z4@j6hcplnmpkvc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: a8241731-2a71-4997-a538-08dc5ec04620
X-MS-Exchange-SLBlob-MailProps:
	O8uo9vZ0QHVDqkOSoPIz5M4S+SNCRCocen9CD028iTAlNCkVfLjCEeiFekw0TWSS7qY6N7y6f+XzRg8v1+AzRRrLkOokeZl/2MdxcKChtH7hmWx6kGrb0EIPb6DHd77QNDzpd9hKeQSqYA0wonQsdHtX0o7lOkl07wC0ZAMhUVXIDN3BjFuElqdu3sqZldQKRTXnfj/HZqk90WZhWemkY9JsNDA5btVlFZlXOsogmID9BXj0I+cWGMq3/LoZrfzHon0gPtVLi0sj9IjiFDg7Uq2SJs4Ejgcx3GZFvzZ3AiEEwg8oFkyR5I4O4RgNm2DiIBVOVxHyMj5E0uAEiDI3yoIPz6gHBl2xZwiOkiXYRzPwvZmz593/iTwrekUEDRnMXZsD0gTJXswhqYCcj17/JZSULfjmwwqR6M3HQ7qofsYzxq8jZz3i0QocHULxQ2kBiZ4xaC/M4Bi2qn6SwmwWnanowIvft/LhadTiNVolO8U4gdjhpE+OFyXEIqBEGJh+x69CFpktu6uj6Xv6LqydG1FzRI1ZMxIGDlYS0wKpEUca6qeBPVN+1ULZE6GRcZuSESXkIIB9VMZMiJbweseAxrFuuPGZBU5xiRkswMtTpl6BDdWBJAHowHT9l34Y/f8O9uxsB34r3W2rES07yP5na08PHAUZeFoN7AGXQuuCOJoM9ezmfdtANGGt5VJOO6/rOH+GtBSHTkh4gLhRG7TFbjlWElmkTKAsLj3sLdgyfpPcOZXTGe9daGjORWLUi/4OZGA5wN4dMPTqx9N5C+qG3a5HCtCcM1C/NbxZ5pC7QDs9YpokBQlwkzRUzU65C7zIJhWvILop9+mqEkqPLnRgSlNP8/+36DosQBEGMa5nVewjVedanxNXF714sZLBdpa5HdzkzGTllCkKn0aKm/aJUQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LEuwwd7LV1LBPuEcPumCP3Fe9tc0ACUj4MxKhFC/mkwrcimzTlEd+FhHCKi6aqWhP5DAou/oMTnHmEHmyfn/4F9RY6Yefrmi9yoo1yDArSLrsub7a3WtvSig2CLGECtifcUqYeGTfSPUb9VDxLl+/a5SqViX0KMBrJoRqj79tt339QS6YiEhlI+mGq7Xvh8EDkMh0neZ4By/JS3JQVy4JprOpOKdPIJpd0OL7LqwJRn3lYtz0dPXixu3c2BueY8j46LG2frB9NHFHxIGb2SZPIb19ZDYgIlS3EjViYQrBzXLvdwBdpcHYvkAHZ4GGN12ztd/32urAnBnShBEFga1somQKsFdPIevSBTCgbxYkaUeDWpOL3LiFuezESI+vh1Z0XHcrzzHWYVj0NGSjvIAosEcoX7qDu5hVcvtct9HqQnvP/oSUbfZb9bV2WUuhDEKnGu21obyNO+vdlMYxDjOdCkmEju6+yaLCiZwAYgYGYkOFheyCrlM8j/CmKarPpm2NId/JkUfkH+iTEwrhdLsJhpDpCRVqGjFX93i1PC0zaRqPTrnNASjZZFfd6ytmXddR2O+L801RrCkWuVsJgiA5f4g9AfE7ml3Rj7g1myrI0MGUbMZPiQTZ2fTtPdBuIu0IWDlmiDpY2z3vraqknr+BwH56EO/dzuT5xoiGqCml2D5cKnI9M0xjBlA+KsiHLQBOTdNARTi81lrFkQ7JQFl3g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HKe1k5F/jhT69peURPhYNvTpX6Y3i8r0RibfNk5Tf5Kqd6nov2bMtbuuvejd?=
 =?us-ascii?Q?kbq6JucmL3/W3rayqr8UujaM6BA5I0uCyAdvqlRq/d2/wv//EP+MgonkRLLU?=
 =?us-ascii?Q?6dRniePQpMHkLCk6B5VUWoihZ1n4C/Xw5Xmfm8I/zJGYv+bjZfFVtqmioyyH?=
 =?us-ascii?Q?9+5ccbXaB6cpf7/H07cBoNX7tmsZ+80zYf0L1iroi8Hs94KoT5/TeWzxoLIb?=
 =?us-ascii?Q?p+1UYar5AgJpPYCPikhEFzETOL7xJaddiOH/Rz77MXC4yU2GGwqFOZMUo6Ly?=
 =?us-ascii?Q?aLRn5lljCjm5wbbo80OoUJq8FBp1OCaJ+3W0u95t8iG3IFYSKBVNAzPExURR?=
 =?us-ascii?Q?EYmo8578UDtbPJPRnpZZGZWSF1Pq6BUUC0Avr+7L2NYj1XRgPmLKG1iAop1b?=
 =?us-ascii?Q?SGp5v8Pg5inKnLL3VMVmnXQj0utwSVadI9OPfQq5oFN3gI0ihkoXQE+wAudl?=
 =?us-ascii?Q?dzypB9B4f7AqXN48KUMn4gIzBedGsCnlAie0uvR3yBiLX407tKWxwZhh3gZX?=
 =?us-ascii?Q?mbnhSJ3OnDBH/qWx04+Qir+HuV1FUx7vKMnSA+a0UtDA45SIKYugI/2xGQXO?=
 =?us-ascii?Q?CPmEYKbruva+tng4tcSva1fy5v3o9CMVdSjuYoBLxA7rti5AJE6cznWkiwPm?=
 =?us-ascii?Q?jP67hnD46gsFHs8419T4SZ1HIpy8yRjslopBqqzc2cETDrhbk9z2jukcdwwa?=
 =?us-ascii?Q?NPOrPS3EQKeoPVObQNS/RPMJhgXb3Jspw6IN1govhjqguEK+GzP9fCw77RiT?=
 =?us-ascii?Q?doGBR8gnd3F5CdjQ5I6gVmkZkvaA8NOyWzTJyzu3vPOsMlhncXC3+FrPtFxZ?=
 =?us-ascii?Q?cLS2oKxvi6sOeUfy438tAIrEQFESpWU3dttIXnnB/g1t+jt4Rm/H0iyl01kk?=
 =?us-ascii?Q?9vnCIeD1FayaJMO313OmM+FUkRUPoCuvnxi/Kw1tB/l/2gc9YHGi6b6bp7XM?=
 =?us-ascii?Q?EX5bgjgFpUZvbH5LlroyQ0uUFq7hzH3JjbJTrXNrAzGZVRgcYlSwaEwrVzWV?=
 =?us-ascii?Q?P1vyksUguAV7VNO5Ox7xLwREdviZVVcoQY/+s169H/m6zDrLRmvNyurHd814?=
 =?us-ascii?Q?q8RDd2Og8uzJ+LLccWVH+1en34hHDLi0GH6apysy44LUDPziNmsro8LSSGAa?=
 =?us-ascii?Q?AYOAAyEr8A3GbMkvywYMNRvMCOhBalGnvQw6zpsCJrU4XlTAIUCZnPIrIaw+?=
 =?us-ascii?Q?GqrlzGVMPm2E0Rs49bsEAbTUkDyDnDVToxzp2O6OosWALDNAOb3pYlaiZq46?=
 =?us-ascii?Q?RA5o6J7IOFun29EIJeE6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8241731-2a71-4997-a538-08dc5ec04620
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:25:08.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB4405

On Wed, Apr 17, 2024 at 08:53:10AM GMT, michael.opdenacker@bootlin.com wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Document the compatible strings for the Milk-V Duo S board[1] which uses
> the SOPHGO SG2000 SoC, compatible with the SOPHGO CV1800B SoC[2].
> 
> Link: https://milkv.io/duo-s [1]
> Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  Documentation/devicetree/bindings/riscv/sophgo.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> index 9bc813dad098..1837bc550056 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> @@ -21,6 +21,7 @@ properties:
>        - items:
>            - enum:
>                - milkv,duo
> +              - milkv,duos

Please ADD CPU COMPATIBLE, AND NOT JUST USE CV1800B. 
I do not want to say this again.

>            - const: sophgo,cv1800b
>        - items:
>            - enum:
> -- 
> 2.34.1
> 

