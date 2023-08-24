Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F957874C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbjHXP7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242334AbjHXP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:58:52 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F3E198D;
        Thu, 24 Aug 2023 08:58:50 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OCH0qA006574;
        Thu, 24 Aug 2023 15:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=YFDf13HppetYXuS5FUjjJ4wlqlcjj/cD+ZLcRWypgDY=;
 b=C6c7GiVtXYAhlLYQ2sDbNEVBrWONT7M28UiXdbQdzN55a2hvLtejTgnQqb6rJqkXVcC4
 jO4/JfYgXGEwnRC0hzRnbc2RGsCcnJjXRNZSGaSboxSJSEOAl1ppg5lZCJDBzK4n++Zi
 oHFdhe5mllqQZKGXfBy3XIns4WygxaukrOX5mwgD/DcVDlc0nmUEzzAZRTWhfxZ6oaMP
 Um/Mbs66paedB6JK7MyiOTGE4yk1fOSXCnVtGf9y68a9NTWJv0fS0GMe7XrdYwbCAYgp
 w0pzj1GKFsmQyfIgdbJdAvg+mTME2kA+kal4ynYKDRweRf/lIrV54sMz3dd6EhQ1lCgC Gw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3snsr10x01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:57:48 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 1EB93801AC3;
        Thu, 24 Aug 2023 15:57:46 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 2D90C80E0EC;
        Thu, 24 Aug 2023 15:57:42 +0000 (UTC)
Date:   Thu, 24 Aug 2023 10:57:38 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: refactor deprecated strcpy and strncpy
Message-ID: <20230824155234.GA102055@hpe.com>
References: <20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com>
 <CAHp75VeieNZ3+-2oq2yx36mJ0ERBkuF=f_uhAh8o0sFnHY6Wsg@mail.gmail.com>
 <CAFhGd8q1UeaUC-Wm9+Jr=7KZLk-VUn+EsOPP0uc1sFk+cv_yoQ@mail.gmail.com>
 <202308231554.4873EE731@keescook>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202308231554.4873EE731@keescook>
X-Proofpoint-GUID: Njnl-30G6qTEcEJdZA9SmViGE2c8L-Q5
X-Proofpoint-ORIG-GUID: Njnl-30G6qTEcEJdZA9SmViGE2c8L-Q5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 04:00:13PM -0700, Kees Cook wrote:
> On Wed, Aug 23, 2023 at 03:49:34PM -0700, Justin Stitt wrote:
> > On Wed, Aug 23, 2023 at 4:07 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Wed, Aug 23, 2023 at 1:32 AM Justin Stitt <justinstitt@google.com> wrote:
> > > >
> > > > Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> > > > destination strings [1].
> > > >
> > > > A suitable replacement is `strscpy` [2] due to the fact that it
> > > > guarantees NUL-termination on its destination buffer argument which is
> > > > _not_ the case for `strncpy` or `strcpy`!
> > > >
> > > > In this case, we can drop both the forced NUL-termination and the `... -1` from:
> > > > |       strncpy(arg, val, ACTION_LEN - 1);
> > > > as `strscpy` implicitly has this behavior.
> > >
> > > ...
> > >
> > > >         char arg[ACTION_LEN], *p;
> > > >
> > > >         /* (remove possible '\n') */
> > > > -       strncpy(arg, val, ACTION_LEN - 1);
> > > > -       arg[ACTION_LEN - 1] = '\0';
> > > > +       strscpy(arg, val, ACTION_LEN);
> > > >         p = strchr(arg, '\n');
> > > >         if (p)
> > > >                 *p = '\0';
> > >
> > > https://lore.kernel.org/all/202212091545310085328@zte.com.cn/
> > >
> > > ...
> > >
> > > > +               strscpy(uv_nmi_action, arg, strlen(uv_nmi_action));
> > >
> > > strlen() on the destination?!

The original code for the above (strcpy()), copies strlen(arg) assuming null
termination, so strlen(uv_nmi_action) is not correct for this case.  You
probably want to use sizeof of the destination.

> > >
> > > ...
> > >
> > > > -                       strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
> > > > +                       strscpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
> > >
> > > Again, this is weird.
> > 
> > This is a common pattern with `strxcpy` and `sizeof` if you `$ rg
> > "strncpy\(.*sizeof"`. Do you recommend I switch the strlen(dest) to
> > strlen(src)? I only kept as-is because that's what was there
> > originally and I assumed some greater purpose of it.
> 
> It's best to avoid any assumptions. If it can't be answered through code
> inspection, the next best thing would be to ask for clarification. In
> looking I see uv_nmi_action is a string:
> 
> arch/x86/platform/uv/uv_nmi.c:193:typedef char action_t[ACTION_LEN];
> 
> arch/x86/platform/uv/uv_nmi.c:          strcpy(uv_nmi_action, arg);
> arch/x86/platform/uv/uv_nmi.c:module_param_named(action, uv_nmi_action, action, 0644);
> arch/x86/platform/uv/uv_nmi.c:  return (strncmp(uv_nmi_action, action, strlen(action)) == 0);
> arch/x86/platform/uv/uv_nmi.c:                  strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
> 
> using strlen() here seems "accidentally safe", as it's overwriting
> "kdump":
> 
>         if (uv_nmi_action_is("kdump")) {
>                 uv_nmi_kdump(cpu, master, regs);
> 
>                 /* Unexpected return, revert action to "dump" */
>                 if (master)
>                         strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
> 
> anyway, a simple "sizeof" should be used AFAICT.
>

I agree.
