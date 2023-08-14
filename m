Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81277B4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjHNJBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbjHNJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:00:41 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A773A88
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1692003615;
        bh=edGwPpyVyn/vyK03wlum1jlhOhAouMJrXmcB8fOlahk=;
        h=Subject:From:To:Cc:Date:From;
        b=jleEd7lwYJIqT6BEXnqjcQbFQseHwE4x6YVeyJeIKQmnq1AlpgpxLKLS42wgg/aMa
         XlFmswJ40Gl8iNiyW4q/4B/jAaP9bvOdcH26bdCMnvKUduOMwmsS5V4dgz9lvyxO7k
         56mf4cAGvuVSRGBmc/Mv3D99innYB3+azTFF/M9Q=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 22A0E659AC;
        Mon, 14 Aug 2023 05:00:13 -0400 (EDT)
Message-ID: <79c179acaa6ec4e1cf112ae2dfce8370694a5089.camel@xry111.site>
Subject: Does srso safe RET mitigation require microcode update?
From:   Xi Ruoyao <xry111@xry111.site>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Rainer Fiebig <jrf@mailbox.org>
Date:   Mon, 14 Aug 2023 17:00:12 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There seems a difference between Documentation/admin-guide/hw-
vuln/srso.rst and the actual behavior.  The documentation says:

   First of all, it is required that the latest microcode be loaded for
   mitigations to be effective.

And:

    * 'Vulnerable: no microcode':
  =20
      The processor is vulnerable, no microcode extending IBPB
      functionality to address the vulnerability has been applied.

Per the text, if there is no firmware update, the system is just
vulnerable.  But on a real Zen 3 system, the spec_rstack_overflow file
contains "Mitigation: safe RET, no microcode".

So we are puzzled now: is this system vulnerable or mitigated?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
