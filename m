Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7497829D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjHUNB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjHUNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED7CD;
        Mon, 21 Aug 2023 06:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF476614F3;
        Mon, 21 Aug 2023 13:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2088DC433D9;
        Mon, 21 Aug 2023 13:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692622914;
        bh=jRjj6/i45ISAqAgmwrx/DQ8yITENPJ7mT9VW43TABG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bw8TqkcrGyVtu2cNtKRWLUPkTS+l57cRbhbtkbmdP2e8xnnQWCUuSxVGese6DYpof
         aH3Mof+PZiThtiwKMP/u7KdvAiO8rsWZ6VXZQufP69koIXniTaKr1D0BZvhruEiYSA
         z9GxswYJUzzeN6qZYQn2Z+xHEaylL6/t38P1kuVAMcESfWrbJdXfjej+vEvrQXPlWD
         y/sel6+ZgZnVree34y2UoNiiJm9rIie3ZStq3FxOIcxMMiiiarW12P7k9ny06PsFV8
         K8n4OFGxQRXZ22SIpI4gadPsIVkpi0J16LWlZd1pWuYR9BaTmJk8RPqIUCelnuf7qO
         y4OnfcVnX+cuA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 919B940722; Mon, 21 Aug 2023 10:01:51 -0300 (-03)
Date:   Mon, 21 Aug 2023 10:01:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ian Rogers <irogers@google.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Raise exception for no definition of a
 arch std event
Message-ID: <ZONgPy7pK7Qc7Cc6@kernel.org>
References: <20230807111631.3033102-1-john.g.garry@oracle.com>
 <373e8253-656c-84dc-c05-b578e3725d@os.amperecomputing.com>
 <CAP-5=fVsePTVU2qeeUzVFkWA7Oxj6bgSq+yWzO=t3y283vOgOw@mail.gmail.com>
 <dd4bc3fe-5b8e-6e64-bcec-29263df43086@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd4bc3fe-5b8e-6e64-bcec-29263df43086@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 21, 2023 at 11:46:20AM +0100, John Garry escreveu:
> On 10/08/2023 20:27, Ian Rogers wrote:
> > On Wed, Aug 9, 2023 at 10:11 PM Ilkka Koskinen
> > <ilkka@os.amperecomputing.com> wrote:
> > > 
> > > 
> > > Hi John,
> > > 
> > > On Mon, 7 Aug 2023, John Garry wrote:
> > > > Recently Ilkka reported that the JSONs for the AmpereOne arm64-based
> > > > platform included a dud event which referenced a non-existent arch std
> > > > event [0].
> > > 
> > > I wish I had found the bug in my patch a long time ago but, in fact, it
> > > was Dave Kleikamp who initially pointed it out to me and figured out the
> > > difference between jevents.c and jevents.py when porting the patch to 5.15
> > > kernel.
> > > 
> > > https://urldefense.com/v3/__http://lists.infradead.org/pipermail/linux-arm-kernel/2023-June/844874.html__;!!ACWV5N9M2RV99hQ!It9EhKK4s2uBUJyQvLg-ruUfENAA6Sw7TWVo_hF8XmFoQ6q565iYafTnN-yoBNh3EQ1IFa2tHknUjNHs5dI$
> > > 
> > > > 
> > > > Previously in the times of jevents.c, we would raise an exception for this.
> > > > 
> > > > This is still invalid, even though the current code just ignores such an
> > > > event.
> > > > 
> > > > Re-introduce code to raise an exception for when no definition exists to
> > > > help catch as many invalid JSONs as possible.
> > > > 
> > > > [0] https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com/__;!!ACWV5N9M2RV99hQ!It9EhKK4s2uBUJyQvLg-ruUfENAA6Sw7TWVo_hF8XmFoQ6q565iYafTnN-yoBNh3EQ1IFa2tHknU_t28TiE$
> > > > 
> > > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > 
> > > Thanks for the patch! I quickly tested it and it worked as expected. Just
> > > in case this is needed:
> > > 
> > > Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Hi Arnaldo,
> 
> Can you consider applying this patch along with https://lore.kernel.org/linux-perf-users/CAP-5=fX2uE=B_Vb90nn5EV0mw+AJBpjDecP9w29OUn=j7HKPPg@mail.gmail.com/
> 
> I think that we should expect another version of that series with changes
> elsewhere.

Done, thanks for the ping.

- Arnaldo
 
> Thanks,
> John
> 
> > 
> > Thanks,
> > Ian
> > 
> > > Cheers, Ilkka
> > > 
> > > > ---
> > > > Please do not apply before [0], above.
> > > > 
> > > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > > > index 8cd561aa606a..98cccc3fcbbd 100755
> > > > --- a/tools/perf/pmu-events/jevents.py
> > > > +++ b/tools/perf/pmu-events/jevents.py
> > > > @@ -347,12 +347,15 @@ class JsonEvent:
> > > >        if self.desc and not self.desc.endswith('. '):
> > > >          self.desc += '. '
> > > >        self.desc = (self.desc if self.desc else '') + ('Unit: ' + self.pmu + ' ')
> > > > -    if arch_std and arch_std.lower() in _arch_std_events:
> > > > -      event = _arch_std_events[arch_std.lower()].event
> > > > -      # Copy from the architecture standard event to self for undefined fields.
> > > > -      for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
> > > > -        if hasattr(self, attr) and not getattr(self, attr):
> > > > -          setattr(self, attr, value)
> > > > +    if arch_std:
> > > > +      if arch_std.lower() in _arch_std_events:
> > > > +        event = _arch_std_events[arch_std.lower()].event
> > > > +        # Copy from the architecture standard event to self for undefined fields.
> > > > +        for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
> > > > +          if hasattr(self, attr) and not getattr(self, attr):
> > > > +            setattr(self, attr, value)
> > > > +      else:
> > > > +        raise argparse.ArgumentTypeError('Cannot find arch std event:', arch_std)
> > > > 
> > > >      self.event = real_event(self.name, event)
> > > > 
> > > > --
> > > > 2.35.3
> > > > 
> > > > 
> 

-- 

- Arnaldo
