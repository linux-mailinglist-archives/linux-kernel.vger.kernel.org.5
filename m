Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A577807BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358883AbjHRJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358937AbjHRJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:01:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F13C4216;
        Fri, 18 Aug 2023 02:01:23 -0700 (PDT)
Received: from pwmachine.localnet (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id A871C211F7CD;
        Fri, 18 Aug 2023 02:01:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A871C211F7CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692349282;
        bh=j4cvRkD6pbPZwfZqBlOWlJWUpvusQxy2wWaKUpGqnmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pMsqSFq2iFNzcIysA8uMgUW0kwwAywjuDll59W0p15LRa72KhmdV5tMaSVSgdPXHf
         jWIBDsH0yPGTvZMTuaEuXj3txWWBR5aDXpXbx9KKiBYDmvAZRN3u/3br5jGFBAiAXA
         Gh5PDTr3KUYfPB2QE7Xgshc0eGq07570hDfSqQOk=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date:   Fri, 18 Aug 2023 11:01:19 +0200
Message-ID: <5702105.DvuYhMxLoT@pwmachine>
In-Reply-To: <20230817111303.47b50197@gandalf.local.home>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com> <4852847.31r3eYUQgx@pwmachine> <20230817111303.47b50197@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le jeudi 17 ao=FBt 2023, 17:13:03 CEST Steven Rostedt a =E9crit :
> On Thu, 17 Aug 2023 12:59:30 +0200
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > Why can't you just pass in the address like sysfs does?
> >=20
> > To get the addresses from /proc/kallsyms, you need to either have
> > CAP_SYSLOG or even CAP_SYS_ADMIN.
> > But to call perf_event_open(), you only need CAP_PERFMON.
> > This way, by giving only the name you can trace function with less
> > privileges (i.e. without CAP_SYS_ADMIN).
> > Please correct me if I am wrong as I am not an expert in knowing the
> > minimal set of capabilities you need to trace.
>=20
> I wonder if we should add an option to put in the non-relocated address?
> One that can be acquired by debuginfo in the vmlinux. I'm assuming that t=
he
> kernel has access to the added offset (I haven't looked). If it does, then
> we could allow users to just add something like "+@0xffffffffdeadbeef" and
> add the relocation offset to get to the mapped address of the function.
>=20
> This would allow those without kallsym privileges to pass in kernel addre=
ss
> for tracing.

This seems interesting but I am wondering about this when using KASLR.
Would it be possible to compute the final address as:
final_address =3D debuginfo_address + relocation_offset + kaslr_offset?
I will check regarding both the relocation offset and how KASLR works (I on=
ly=20
know what it does, not how it does it).

Moreover, regarding accessing vmlinux, I can only think to access it throug=
h=20
vmlinuz which is in /boot.
Sadly, you cannot read /boot/vmlinuz without being root on a several=20
distributions.
Note that, the same occurs for /boot/System.map*.

> -- Steve

Best regards.


