Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA6772A27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjHGQIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHGQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:07:59 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC57E76
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:07:58 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56ced49d51aso3093663eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691424478; x=1692029278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvp0Im2jERoENlVFddwH2D6QjN3toaA5fFOgnirZ+R4=;
        b=U55HARtByMC4OyceVCd/0PPVCaIicxfv7bSGUg8MW10YfcLxHL34MPs/8RlVOKAZVi
         KKtZU8EttyLh3UlEJzS91vdLnAAKPkjgXwtkaNp/XiZ/FnfG7kr03lOsdeDODWo70VFu
         lMbdcoCz579uQkmhTEChdnmJhsS5yjz6fhpl+4fS1+FfFmXQ/+lZTRnrv3SpT984J3V9
         8yKg1iis3Ri+cC6YEBvuF+YQFd628usTU0x3kg6PX45CiZVQQi73+hT+tQcerj9YH7wL
         dQYH+TckHGw61GDVB94uciobkd6dvCQqD60CX2WQqIIZWHrJmYAvWMHCYEmr4Gv3ZK+C
         IhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691424478; x=1692029278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvp0Im2jERoENlVFddwH2D6QjN3toaA5fFOgnirZ+R4=;
        b=PfOW6ozJaif66wd49z8hLXRIow150B97LdhhaJ/7Qrggunypb7G9KZ1F76yHAL2btm
         cRb3OWjTK43jUKC67FNdlPYlgVkRx57o0e+VzOYWHUQIGUW34xnXREEa4hf2enXDO77V
         IHxLu9RbgjRJsNhZ7nQEfEv1y6HJIXQYYtIxVJax6/0dpdgPnmZ4c7T4AA6ratTIKyLq
         u6j+bXsqeM7jvKo8BVe76gvjtC4RldU8LPJKvXc6TIz9Li0ww3c2OdFfppNO+jw3kYva
         s/i+6YUjytmKqbGHLTdSXV9xQ9k8sAHcEyOMrlaMGZhrG/D3Wij9ZI4cD1FKp9hQ0wfc
         qUKQ==
X-Gm-Message-State: AOJu0YwGGjgdsAhDOto1frigZZ5z/JHrC/Uv5DTPiIxdYAKYNnYaCHeQ
        XWWXbn5EvR0YMiJXx07FgfSCemZPN3vlJAJglgg=
X-Google-Smtp-Source: AGHT+IEFC2EEhA995dbjDMCvSc1+hRBBsJcb7KF5pkNj1JvW4ltm4fMO41/dJ1a3fTEV+7RHFC9E2Thl4oeu+fc5QIw=
X-Received: by 2002:a4a:cb8c:0:b0:56d:4ed3:333c with SMTP id
 y12-20020a4acb8c000000b0056d4ed3333cmr6676127ooq.1.1691424478021; Mon, 07 Aug
 2023 09:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230807130108.853357011@linutronix.de> <20230807135027.168401504@linutronix.de>
In-Reply-To: <20230807135027.168401504@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Aug 2023 19:07:22 +0300
Message-ID: <CAHp75Vf_eWrcx62W22rDjTSjCAVxEVuC1oCgasO_-p-K5xLJ8w@mail.gmail.com>
Subject: Re: [patch 14/53] x86/platform/intel-mid: Prepare for separate
 mpparse callbacks
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 4:52=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> Initialize the split SMP configuration callbacks with NOOPs as MID is
> strictly ACPI only.

Not really, but we decided to support only ACPI configurations in the kerne=
l.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
