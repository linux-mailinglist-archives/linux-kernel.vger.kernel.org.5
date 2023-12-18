Return-Path: <linux-kernel+bounces-4329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC09817B94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DFC1C22D10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67172047;
	Mon, 18 Dec 2023 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hQr7MjQT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771246FB6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIJYC7s012459;
	Mon, 18 Dec 2023 20:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hMBeBrq8quQH6CPv+lImN6QdJACxbXf9tSZyXHlRo4E=; b=hQ
	r7MjQTkCnHevdZk/xZNlTOlCzJByyg1VJ4qM1AvnQp7UvqyZMO3Euds7jhtt8eED
	OcKCPEg5dYfNJZ8GfHjZanYk/zmti7OuY96PncHIBR+de1aOMRqW5OGlafx0VYdd
	T6J2BLs4C04WMNvgbHXroA7wNkeRhW97c+WEqnfttD9NRG5M9Amm2Gt4kyGMFcSy
	U5g1g3y1ezrPkhtx4TK7/hE0PZHETFSeR45h7OhjiNI1eui5V20THu8LYXFjEn58
	zNlwdXmauJhNUv/0fkUra032kIINL6L4Uq0Oc54AGc7cR/uqfJH0NDZPiwfMHbVn
	b4PPPVG+YzzSi1JnREFQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0hpr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 20:08:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BIK8FP3001220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 20:08:15 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 12:08:14 -0800
Message-ID: <d6f23512-cec4-4b82-aa6e-d3c98e86e29f@quicinc.com>
Date: Mon, 18 Dec 2023 12:08:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: optionally use LLVM
 utilities
To: Carlos Llamas <cmllamas@google.com>,
        Nathan Chancellor
	<nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, Tom Rix
	<trix@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
        Will Deacon
	<will@kernel.org>, John Stultz <jstultz@google.com>,
        Masahiro Yamada
	<masahiroy@kernel.org>
References: <20230929034836.403735-1-cmllamas@google.com>
Content-Language: en-US
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230929034836.403735-1-cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lmPUyfD68-W5Tb92sDkUuf027cFXOKdZ
X-Proofpoint-GUID: lmPUyfD68-W5Tb92sDkUuf027cFXOKdZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=823 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180150



On 9/28/2023 8:48 PM, Carlos Llamas wrote:
> GNU's addr2line can have problems parsing a vmlinux built with LLVM,
> particularly when LTO was used. In order to decode the traces correctly
> this patch adds the ability to switch to LLVM's utilities readelf and
> addr2line. The same approach is followed by Will in [1].
> 
> Before:
>   $ scripts/decode_stacktrace.sh vmlinux < kernel.log
>   [17716.240635] Call trace:
>   [17716.240646] skb_cow_data (??:?)
>   [17716.240654] esp6_input (ld-temp.o:?)
>   [17716.240666] xfrm_input (ld-temp.o:?)
>   [17716.240674] xfrm6_rcv (??:?)
>   [...]
> 
> After:
>   $ LLVM=1 scripts/decode_stacktrace.sh vmlinux < kernel.log
>   [17716.240635] Call trace:
>   [17716.240646] skb_cow_data (include/linux/skbuff.h:2172 net/core/skbuff.c:4503)
>   [17716.240654] esp6_input (net/ipv6/esp6.c:977)
>   [17716.240666] xfrm_input (net/xfrm/xfrm_input.c:659)
>   [17716.240674] xfrm6_rcv (net/ipv6/xfrm6_input.c:172)
>   [...]
> 
> Note that one could set CROSS_COMPILE=llvm- instead to hack around this
> issue. However, doing so can break the decodecode routine as it will
> force the selection of other LLVM utilities down the line e.g. llvm-as.
> 
> [1] https://lore.kernel.org/all/20230914131225.13415-3-will@kernel.org/
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
>  scripts/decode_stacktrace.sh | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 564c5632e1a2..bfe5a4082d8e 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -16,6 +16,21 @@ elif type c++filt >/dev/null 2>&1 ; then
>  	cppfilt_opts=-i
>  fi
>  
> +UTIL_SUFFIX=
> +if [[ -z ${LLVM:-} ]]; then
> +	UTIL_PREFIX=${CROSS_COMPILE:-}
> +else
> +	UTIL_PREFIX=llvm-
> +	if [[ ${LLVM} == */ ]]; then
> +		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
> +	elif [[ ${LLVM} == -* ]]; then
> +		UTIL_SUFFIX=${LLVM}
> +	fi
> +fi
> +
> +READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
> +ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
> +
>  if [[ $1 == "-r" ]] ; then
>  	vmlinux=""
>  	basepath="auto"
> @@ -75,7 +90,7 @@ find_module() {
>  
>  	if [[ "$modpath" != "" ]] ; then
>  		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
> -			if readelf -WS "$fn" | grep -qwF .debug_line ; then
> +			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
>  				echo $fn
>  				return
>  			fi
> @@ -169,7 +184,7 @@ parse_symbol() {
>  	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
>  		local code=${cache[$module,$address]}
>  	else
> -		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
> +		local code=$(${ADDR2LINE} -i -e "$objfile" "$address" 2>/dev/null)
>  		if [[ $aarray_support == true ]]; then
>  			cache[$module,$address]=$code
>  		fi

