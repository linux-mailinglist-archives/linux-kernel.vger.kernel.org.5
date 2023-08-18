Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F693780AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376572AbjHRLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352927AbjHRLSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:18:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465BE3AB2;
        Fri, 18 Aug 2023 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692357512;
        bh=4PjeEkx4aBPMQUwm4BVpDzhj+bdvfmdCom8/6aO1EuQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=djSPoo8XEakClexedz5VHK0XAnbYFl1AB9sSKJR/+v0qiw2S/iJq1YYIGfNyof0Pj
         AjroU+w+RbY47+XuZ6VPNJHDu4Qzvex5keZ4B1vfkzcynv7YuIkRYub97rSjRF/ZrM
         fO5EbAZz3DNS1NJOq/EZfZEKYDhJK4md1Empx6ggh+9W1tuu1lkLgnLbu/E3nwJlfc
         nJUZYadVeJBPrj98Dz8MLr33eFmTks7Vr300gmNZnxCyCq7Mli0Gh95JTTIgqtJSAJ
         u35yf9Q7RiMn+P3WSEfwFpb3ViL74meGV+Kgs6qQnkGLvtMr3ZEV1UwWto3F6DtE59
         Rs9acNe23ublQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRzrj65skz4wb0;
        Fri, 18 Aug 2023 21:18:29 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Enable generic cpu idle-loop
In-Reply-To: <20230818050739.827851-1-vaibhav@linux.ibm.com>
References: <20230818050739.827851-1-vaibhav@linux.ibm.com>
Date:   Fri, 18 Aug 2023 21:18:24 +1000
Message-ID: <875y5cwqdb.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vaibhav Jain <vaibhav@linux.ibm.com> writes:
> This minor patch enables config option GENERIC_IDLE_POLL_SETUP for arch
> powerpc. This should add support for kernel param 'nohlt'.

Which is named after an 8086 instruction :), but oh well.

> Powerpc kernel also supports another kernel boot-time param called
> 'powersave' which can also be used to disable all cpu idle-states and
> forces CPU to an idle-loop similar to what cpu_idle_poll() does. This
> patch however makes powerpc kernel-parameters better aligned to the
> generic boot-time parameters.

It would be nice if we could make our powersave=off parameter just
enable this generic logic.

Have you looked at if that's possible? At a glance it looks like it
should be, when cpu_idle_force_poll is true do_idle() never calls
cpuidle_idle_call(), so the cpuidle drivers are never invoked.

cheers
