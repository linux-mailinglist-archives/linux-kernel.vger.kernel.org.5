Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516217AE6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjIZHYM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 03:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:24:10 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4427DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 00:24:03 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id CA9F0140761;
        Tue, 26 Sep 2023 07:24:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id CB4CA2002C;
        Tue, 26 Sep 2023 07:23:58 +0000 (UTC)
Message-ID: <f0de36d5f8f3687c873616ac3bae698f2aa61020.camel@perches.com>
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary
 search
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jack Brennen <jbrennen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, maskray@google.com, cleger@rivosinc.com,
        kernel-team@android.com
Date:   Tue, 26 Sep 2023 00:23:57 -0700
In-Reply-To: <CAK7LNARd_pRWWso49C4MoahFAM9idyOFC+9ZFYdpS87CA4UTqQ@mail.gmail.com>
References: <20230918210631.3882376-1-jbrennen@google.com>
         <20230925205933.2869049-1-jbrennen@google.com>
         <CAK7LNARd_pRWWso49C4MoahFAM9idyOFC+9ZFYdpS87CA4UTqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: CB4CA2002C
X-Stat-Signature: y9s3jquo39tzmxs37yi73zyeiazbpeb4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+khqWz5TU1xoTnJNYXZ46+Dt8aB1w98N0=
X-HE-Tag: 1695713038-119367
X-HE-Meta: U2FsdGVkX18QhCLbRGcDW559Kb8YTNrEohGutUbc4O+Pvg+b4aqU91yYlhADoZCgd9f/jp28+UHLUpE4ffKbbEmduuSR+WqZN+KdDlN2LwZbUKM8HG66edbia7pEkhExngeVwVl9dbASKITDgflHX2EMdjkgv/VJklMzWrUldVIl2x4c4iII9r9uunhdyqJQJ6yEBzPrguKiVLf9Tjuy/cChnp1fqpcSaIIoDKBnPTtgUQNUj9xtosuHHcvhSB9ntT5Ls1dFXK4YT4xEy+qNzt7a03laYkj3k0c0YUNXOXPKQ3CmR/tSS1tKYwzF9V9epRqeYFdSMEYKHDnk0j5yJWNMyrWc++SZsezDyAr+vtvYIkeTJEQ5bC97lyBnCr+uFfUi7KWT310=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 15:46 +0900, Masahiro Yamada wrote:
> On Tue, Sep 26, 2023 at 5:59 AM Jack Brennen <jbrennen@google.com> wrote:
> 
> > +Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
> > +                               unsigned int secndx, bool allow_negative,
> > +                               Elf_Addr min_distance)
> > +{
> > +       size_t hi = elf->symsearch->table_size;
> > +       size_t lo = 0;
> > +       struct syminfo *table = elf->symsearch->table;
> > +       struct syminfo target;
> > +
> > +       target.addr = addr;
> > +       target.section_index = secndx;
> > +       target.symbol_index = ~0;  /* compares greater than any actual index */
> > +       while (hi > lo) {
> > +               size_t mid = lo + (hi-lo)/2;   /* Avoids potential overflow */
> > +
> > +               if (syminfo_compare(&table[mid], &target) > 0)
> > +                       hi = mid;
> > +               else
> > +                       lo = mid+1;
> 
> My preference is "low = mid + 1" over "low = mid+1"
> 
> Documentation/process/coding-style.rst suggests spaces
> around binary operators.
> 
> "
> Use one space around (on each side of) most binary and ternary operators,
> such as any of these::
> 
>         =  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
> "
> 
> I can see the corresponding line in the checkpatch tool:
> 
> https://github.com/torvalds/linux/blob/v6.5/scripts/checkpatch.pl#L5330
> 
> 
> I wonder why the checkpatch did not detect it.
> 
> Maybe, Joe Perches may know the reason.

checkpatch requires --strict to emit that message.

