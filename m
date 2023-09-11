Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50F779A31A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjIKF7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIKF7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:59:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0499;
        Sun, 10 Sep 2023 22:59:14 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5lQ8U007138;
        Mon, 11 Sep 2023 05:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=dZAGyFQcx1cPl/o4k8GpkwuSomaOIwoePGLjBcUC4LI=;
 b=l/KbjoxtDU4I6+RM8zPiJtydqIvAO+wiMEFJfZwZykA4TtbE8stgN5Uh8UsjBmBGP5fU
 Xm20GOlE/6/7r1EzQh1buGkjQfAmuzUTawFPcfdmDIHS0sLTQ9fRrxd0Pi3jSvv3Po6h
 Wyi1Bz54XPT4fmh5MQQsa7CxXLMrJo0Nk/aXRBNJe1PGmpaWLnUxKYECD+65OYFhH/4K
 x2134OIn10WMVCzZdeC4im6QX582QwRvi4Xj/ueBRpqQ1+9CO7n1N4EmAU3+hBnELeDS
 4c37u/+pc48RYEBnolC9HPSfGoQGn1SagFFMs2Wk97lf5KPMiYlGyjyyI0fhLO7BB5V1 rA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1w2ag6cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:59:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5bL0j002932;
        Mon, 11 Sep 2023 05:59:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkg1xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:59:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38B5x5AG50856380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 05:59:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D59120043;
        Mon, 11 Sep 2023 05:59:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFD8420040;
        Mon, 11 Sep 2023 05:59:04 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Sep 2023 05:59:04 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND][PATCH] tracing/synthetic: Fix order of struct
 trace_dynamic_info
References: <20230908163929.2c25f3dc@gandalf.local.home>
Date:   Mon, 11 Sep 2023 07:59:04 +0200
In-Reply-To: <20230908163929.2c25f3dc@gandalf.local.home> (Steven Rostedt's
        message of "Fri, 8 Sep 2023 16:39:29 -0400")
Message-ID: <yt9d8r9djlnb.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9xj_OZS3x0-UZKOZM2T07XHifNHEZLlu
X-Proofpoint-GUID: 9xj_OZS3x0-UZKOZM2T07XHifNHEZLlu
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309110051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Steven Rostedt <rostedt@goodmis.org> writes:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> To make handling BIG and LITTLE endian better the offset/len of dynamic
> fields of the synthetic events was changed into a structure of:
>
>  struct trace_dynamic_info {
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> 	u16	offset;
> 	u16	len;
>  #else
> 	u16	len;
> 	u16	offset;
>  #endif
>  };
>
> to replace the manual changes of:
>
>  data_offset = offset & 0xffff;
>  data_offest = len << 16;
>
> But if you look closely, the above is:
>
>   <len> << 16 | offset
>
> Which in little endian would be in memory:
>
>  offset_lo offset_hi len_lo len_hi
>
> and in big endian:
>
>  len_hi len_lo offset_hi offset_lo
>
> Which if broken into a structure would be:
>
>  struct trace_dynamic_info {
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> 	u16	len;
> 	u16	offset;
>  #else
> 	u16	offset;
> 	u16	len;
>  #endif
>  };
>
> Which is the opposite of what was defined.
>
> Fix this and just to be safe also add "__packed".
>
> Link: https://lore.kernel.org/all/20230908154417.5172e343@gandalf.local.home/
>
> Cc: stable@vger.kernel.org
> Fixes: ddeea494a16f3 ("tracing/synthetic: Use union instead of casts")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>
>  [ Resending to the correct mailing list this time :-p ]
>
>  include/linux/trace_events.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 12f875e9e69a..21ae37e49319 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -62,13 +62,13 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
>  /* Used to find the offset and length of dynamic fields in trace events */
>  struct trace_dynamic_info {
>  #ifdef CONFIG_CPU_BIG_ENDIAN
> -	u16	offset;
>  	u16	len;
> +	u16	offset;
>  #else
> -	u16	len;
>  	u16	offset;
> +	u16	len;
>  #endif
> -};
> +} __packed;
>  
>  /*
>   * The trace entry - the most basic unit of tracing. This is what

This issue was also present on BE, but as you noted "covered" by the
broken test case. With this patch everything works as expected. So:

Tested-by: Sven Schnelle <svens@linux.ibm.com>

