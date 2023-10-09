Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405CB7BE8D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377361AbjJISBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376857AbjJISBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:01:02 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA03599;
        Mon,  9 Oct 2023 11:00:56 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F336C40E01A5;
        Mon,  9 Oct 2023 18:00:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l14zqUD_KWCT; Mon,  9 Oct 2023 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696874452; bh=xFPuEx15C+gb30iLQTl5YTKox+P0I9H0nLjaW9Geitk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZYF0PwZ23FZbpyqkAk5pzE8JonOQgygko5jlCm3z5q/wypKEPpIqo++W32TItEAJ
         7Vt9zmjHAXRuzwv0Go+kdjNZBUzs6pbJ3YCaxUu6qHwRAGyrH1HBiV4Wayy++dPfW2
         suIitgipdHIERm9wLhuLNKWMJsuQVdJV6Q+pU7g4jFG9ws/PuFsFid+ibEVs7jpXrT
         UlO7G3zTkl3B9z7gUu/43YHlZxg6nntzNSsHVXNReiLp1NdVeX2zYHSIsqrgahc3BW
         Zv7Dlxgx0VZJUPXfsyBCCCs+g1YrM2ML5y6WIB2+MQ/nar8aZ0B6UZDIOPuhHl5n6n
         UHFRuFWR9FUE/Gi88pD1H3/Fnq5tryPBvjyXFg/PsCtD3euJ5oE+p1ZVZ9NCJ9yNI9
         0gtQbPnuwpVujD3I+TawU8NonqVpxVaeC7yK3pZkZowQO7bKfFBOiCaCBbCjoki8wv
         7x7qU2GPj2lUWzPLFb2VCHR/q8J8cITFY9OsYeh9p7xSjs/k9Jj4fFs4YjDyhaEEFq
         SjMO0Gs2i5+Isc4f1oEkM83OXD44SL1s48mkgKuRDoCliEQP4NrM0/BOWeNQ/qfOIK
         mBZz53RK9f29IKpRCIP0z4VNHwzSn8Pofc3oR2gfcFsVJyE53j1+zx9EcL2EZQ+HVG
         vX1uESuv5l0N7XB6TMhgW1gY=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E795F40E0187;
        Mon,  9 Oct 2023 18:00:17 +0000 (UTC)
Date:   Mon, 9 Oct 2023 20:00:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v11 09/10] x86/resctrl: Add support for the files for MON
 groups only
Message-ID: <20231009180017.GSZSQ/sWAwfaFr/G3w@fat_crate.local>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-10-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003235430.1231238-10-babu.moger@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 06:54:29PM -0500, Babu Moger wrote:
> A later patch introduces the first monitoring specific (RFTYPE_MON)
> file for resource groups. Ensure that files with the RFTYPE_MON
> flag are created for CTRL_MON groups.

You don't need that paragraph here. The "later patch" can talk about it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
