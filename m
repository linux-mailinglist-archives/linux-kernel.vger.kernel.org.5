Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB187CB51D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjJPVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:11:24 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F96CA2;
        Mon, 16 Oct 2023 14:11:21 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DFED440E014B;
        Mon, 16 Oct 2023 21:11:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aUCT3b3htChH; Mon, 16 Oct 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697490677; bh=F91l+IVyFain1pq6gedH/p3bRSAVTBnqqVgbpwXDdyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cq5XqvF2VowCc+rZsmNTbWwhBIQ4SJ+c1DbVgfh0phKYuEeK/6wF4bXch3WtIICCG
         INO/eUjvXVPLOmqM1Zs18hwd9MCCuo5YloogDu/BtmzP3v2CQV+xn3I9q5p9UUExGT
         e+9FVaxbN0eUpkvmjHM1RGUq6s7Dc61efdwNx3lNZ4AoHzd0PyPd1XwSKvvrNdSW65
         cvVTayOlFbHHVyw49Y4SChSH9jKb/yTKJ1waFATMcMyeDA3ClUWlSh39+h+ChQdRWv
         +4s/oZTqdEOq6bTh6M557lp5K+43x0EMwIX6+GRLkxxgDmqkz/DgnGOtMr2Fl0mamV
         rs1rub168fPOk7fO+GkbM/Uxp0Ru0HOlXND1GFqpAyvLJBzoeEoKn+eesF7Ic9AakT
         q/TBymh22ZSFFbMVqLGWp2dbuMTGVeyukDK8SpDfyuKfzfZopQZf/J3UGzISvrKZaK
         s57Yn4vlJJTgrEkzLzSakv3FQN/bjudVEcj/JYY3k645Zyqcxv2OopxXzG0YkODREx
         UnRQriFXE0P89oKYV64zzDfwb+bpcE0zNcmD6YXZt1ZkU6cV7J3LZzfIj74Phy2DWu
         /EafPbdJwnMls7RVnQvVaeFi4wDggBjw06OVIrfYM6K1+FZJDX93aqVIy+GexCIZkG
         CHPM2eXe2bA2XAcORj0f3n7g=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5C4440E01B1;
        Mon, 16 Oct 2023 21:10:42 +0000 (UTC)
Date:   Mon, 16 Oct 2023 23:10:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
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
Subject: Re: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Message-ID: <20231016211017.GFZS2mufnu+hTADrEF@fat_crate.local>
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-5-babu.moger@amd.com>
 <d4a33013-0448-4c36-a168-b3a953024962@intel.com>
 <0acbb031-a84e-1cbc-0857-f087b07a9056@amd.com>
 <299778a6-5ea0-c70d-54d6-1ecdc1b417d6@amd.com>
 <2c86957f-9705-4f24-aa43-60d89f636c31@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c86957f-9705-4f24-aa43-60d89f636c31@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 01:46:42PM -0700, Reinette Chatre wrote:
> This still does not look as though you consider how the document 
> looks after the changes.

Looking how this would take longer, Babu, you could leave out the
documentation changes for now and send the rest of the pile which has
been reviewed.

And then you can take your time and do the documentation stuff after
that.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
