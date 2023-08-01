Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF276B3B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjHALr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjHALrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:47:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E238511A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:47:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9100:a000:2ba:2ec4:c400:5d53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D8856607122;
        Tue,  1 Aug 2023 12:47:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690890439;
        bh=e/6VKfnBw/TDQbyNsut3VlPLcb43kMOPjTqCvRsbv24=;
        h=From:To:Cc:Subject:Date:From;
        b=lmRK1l/5cAo+aAylHsKM6KP71V8jecCCfWibgXrciZT8h6IRlOER4vTwYa6j00t0E
         0JVo5TkN1Xn4KC3NwvQiZJwvbmRWFd4vjPcnlAfK/teI7fxkHeXJovFIfGHzgWt6ss
         DTLSBJCw2bqTihzJBEKxDIUH298apIggTs7MrvEekPmkAcLkaKLULhMYfWQFukbXkR
         xjWj2Zni23RHe83xu+JyC6GzzhNtNVN8LPy/z3kRRgSf37XMPQPeGC3F2WWsrV/C/Z
         Xjnow75jUOO1Tb9I8agHfxmRUt4u1PoGqfwVDvuFc7gOw/OF+7dgW3WbK/FGJtQZay
         YyD5MGOVq7TtA==
From:   ricardo.canuelo@collabora.com (Ricardo =?utf-8?Q?Ca=C3=B1uelo?=)
To:     kernelci@lists.linux.dev, gregkh@linuxfoundation.org,
        thorsten@leemhuis.info, regressions@lists.linux.dev
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: Kernel regression tracking/reporting initiatives and KCIDB
Date:   Tue, 01 Aug 2023 13:47:16 +0200
Message-ID: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm Ricardo from Collabora. In the past months, we=E2=80=99ve been analyzin=
g the
current status of CI regression reporting and tracking in the Linux
kernel: assessing the existing tools, testing their functionalities,
collecting ideas about desirable features that aren=E2=80=99t available yet=
 and
sketching some of them.

As part of this effort, we wrote a Regression Tracker tool [1] as a
proof of concept. It=E2=80=99s a rather simple tool that takes existing
regression data and reports and uses them to show more context on each
reported regression, as well as highlighting the relationships between
them, whether they can be caused by an infrastructure error and other
additional metadata about their current status.  We=E2=80=99ve been using it
mostly as a playground for us to explore the current status of the
functionalities provided by CI systems and to test ideas about new
features.

We=E2=80=99re also checking other tools and services provided by the commun=
ity,
such as regzbot [2], collaborating with them when possible and thinking
about how to combine multiple scattered efforts by different people
towards the same common goal. As a first step, we=E2=80=99ve contributed to
regzbot and partially integrated its results into the Regression Tracker
tool.

So far, we=E2=80=99ve been using the KernelCI regression data and reports a=
s a
data source, we're now wondering if we could tackle the problem with a
more general approach by building on top of what KCIDB already provides.

In general, CI systems tend to define regressions as a low-level concept
which is rather static: a snapshot of a test result at a certain point
in time. When it comes to reporting them to developers, there's much
more info that could be added to them. In particular, the context of it
and the fact that a reported regression has a life cycle:

- did this test also fail on other hardware targets or with other kernel
  configurations?
- is it possible that the test failed because of an infrastructure
  error?
- does the test fail consistently since that commit or does it show
  unstable results?
- does the test output show any traces of already known bugs?
- has this regression been bisected and reported anywhere?
- was the regression reported by anyone? If so, is there someone already
  working on it?

Many of these info points can be extracted from the CI results databases
and processed to provide additional regression data. That=E2=80=99s what we=
=E2=80=99re
trying to do with the Regression Tracker tool, and we think it=E2=80=99d be
interesting to start experimenting with the data in KCIDB to see how
this could be improved and what would be the right way to integrate this
type of functionality.

Please let us know if that's a possibility and if you'd like to add
anything to the ideas proposed above.

Cheers,
Ricardo

[1] https://kernel.pages.collabora.com/kernelci-regressions-tracker/
[2] https://linux-regtracking.leemhuis.info/regzbot/all/
