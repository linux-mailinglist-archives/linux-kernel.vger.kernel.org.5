Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8CF778C10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjHKK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHKK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:28:05 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E6CE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:28:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2355840E01A1;
        Fri, 11 Aug 2023 10:28:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AJOhFDPKpFef; Fri, 11 Aug 2023 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691749680; bh=bzxPTOIMXMlc+twimewXSVorRDRF4sKvqm0xOaxb4XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgzdtE2G/xlrF2lvHxAqY7Y4LMfiowDypsiZncOn2ej/BQSoEelKcrGCsdK2nLEof
         cUundY0OoNtbORT3rPsiJxPVvrm2pFF+XgAxizl9KSjtIZcSoBNNqPTeZP79yxjY9/
         6hozYpZnHbwOlOh3p4B6/BdL6I6Iq0dn62ZptuUCDDkCzpy5XGJHaBBoBGRFLtmpHz
         sfidFS4jn/hC0LP8bIUilN4JqiHe4ROq868cINAEZBQsD6AEmf/9BQtwIVReV1T5Y8
         VXhXQbgzoQrZSYJDIK4zlz96rtzpZnMuEOqkUBfVg+rbisKow/p4lNDUhCpKzvCjCN
         3UGBQ+PWxEBnaPpe1ANH4nJM8/OYCoOC59wDOAcH2MdNMCdwIDJdNom80DXUCMvQC0
         rxni04vgQoyoQicF1zMc1MVfnSl7j9UKhJqWQeigf9MXXl6klnBPuHmLTo88yqkyQ7
         7KAOgGxj5UnPRWJuvrnFMNpJc5aP9gu31XqFA9jWSy8+XTIWqKTwMf0oQml2kVQ0yh
         i7Yo2tgjMYpQi71tCvRktpAJmCtqXZyV15O/HHWp+aa0DwDpVEsM9kVV5p+z4ZBAkw
         2RqQI7r7tL3fs1FKsdvQgctxPbxk9DP8lJRuyqED/KaCg64zIfZ14qK91TKsuXUQRP
         +td83DZXihYuOWrpR6GwymyQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 439DA40E0194;
        Fri, 11 Aug 2023 10:27:53 +0000 (UTC)
Date:   Fri, 11 Aug 2023 12:27:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230811102748.GEZNYNJEeDxTqcOLvj@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
 <20230810161003.i65d37ozlt3d5xse@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810161003.i65d37ozlt3d5xse@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:10:03PM -0400, Josh Poimboeuf wrote:
> I tend to agree that SRSO is a new issue and should have its own sysfs
> and cmdline options (though a separate CONFIG option is overkill IMO).

Yeah, there's a patch floating around adding a config option for every
mitigation. Apparently people want to build-time disable them all.

> The mitigations are unfortunately intertwined, but we've been in that
> situation several times before (e.g., spectre_v2 + intel retbleed).

Yap.

And if you recall, keeping Intel Retbleed from AMD Retbleed apart was
already a PITA at the time so adding yet another one behind that flag
would be madness.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
