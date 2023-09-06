Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1F7935C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjIFG6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjIFG6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:58:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B79F5CFD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:58:17 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 188FD212B18B; Tue,  5 Sep 2023 23:58:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 188FD212B18B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693983497;
        bh=ZIPYZd5pdchX9W8xrgtG5lbsRV2RcT30reKJRBwH/lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d23dPdUVFw5wM1U3HMzSFsiJgJENPnmtUUR1mMgLxqT+7RJAjTLdurY2OV6nB6/N4
         plZJOA8c2lnHZhyuy6XdTsK5gb6PahRR/SHUdOg8rGxDAtos+v/IedoJSBFXzdsNTu
         xpA3fPtlBggI3rby3CDbpHeAV7/LdUI+ugJbq3qQ=
Date:   Tue, 5 Sep 2023 23:58:17 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Message-ID: <20230906065817.GA27879@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230821234844.699818-1-zokeefe@google.com>
 <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
 <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
 <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
 <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com>
 <ZOijSwCa9NFD6DZI@casper.infradead.org>
 <9f967665-2cbd-f80b-404e-ac741eab1ced@redhat.com>
 <CAAa6QmQRFwzXWHEL2d74sX6JuciJeBzprk1NxCWKB6i53gmt6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAa6QmQRFwzXWHEL2d74sX6JuciJeBzprk1NxCWKB6i53gmt6Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 08:09:07AM -0700, Zach O'Keefe wrote:
> On Fri, Aug 25, 2023 at 5:58 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 25.08.23 14:49, Matthew Wilcox wrote:
> > > On Fri, Aug 25, 2023 at 09:59:23AM +0200, David Hildenbrand wrote:
> > >> Especially, we do have bigger ->huge_fault changes coming up:
> > >>
> > >> https://lkml.kernel.org/r/20230818202335.2739663-1-willy@infradead.org
> 
> FWIW, one of those patches updates the docs to read,
> 
> "->huge_fault() is called when there is no PUD or PMD entry present.  This
> gives the filesystem the opportunity to install a PUD or PMD sized page.
> Filesystems can also use the ->fault method to return a PMD sized page,
> so implementing this function may not be necessary.  In particular,
> filesystems should not call filemap_fault() from ->huge_fault(). [..]"
> 
> Which won't work (in the general case) without this patch (well, at
> least the ->huge_fault() check part).
> 
> So, if we're advertising this is the way it works, maybe that gives a
> stronger argument for addressing it sooner vs when the first in-tree
> user depends on it?
> 
> > >> If the driver is not in the tree, people don't care.
> > >>
> > >> You really should try upstreaming that driver.
> > >>
> > >>
> > >> So this patch here adds complexity (which I don't like) in order to keep an
> > >> OOT driver working -- possibly for a short time. I'm tempted to say "please
> > >> fix your driver to not use huge faults in that scenario, it is no longer
> > >> supported".
> > >>
> > >> But I'm just about to vanish for 1.5 week into vacation :)
> > >>
> > >> @Willy, what are your thoughts?
> > >
> > > Fundamentally there was a bad assumption with the original patch --
> > > it assumed that the only reason to support ->huge_fault was for DAX,
> > > and that's not true.  It's just that the only drivers in-tree which
> > > support ->huge_fault do so in order to support DAX.
> >
> > Okay, and we are willing to continue supporting that then and it's
> > nothing we want to stop OOT drivers from doing.
> >
> > Fine with me; we should probably reflect that in the patch description.
> 
> I can change these paragraphs,
> 
> "During the review of the above commits, it was determined that in-tree
> users weren't affected by the change; most notably, since the only relevant
> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
> explicitly approved early in approval logic.  However, there is at least
> one occurrence where an out-of-tree driver that used
> VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken.
> 
> Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> any ->huge_fault handler a chance to handle the fault.  Note that we
> don't validate the file mode or mapping alignment, which is consistent
> with the behavior before the aforementioned commits."
> 
> To read,
> 
> "The above commits, however, overfit the existing in-tree use cases,
> and assume that
> the only reason to support ->huge_fault was for DAX (which is
> explicitly approved early in the approval logic).
> This is a bad assumption to make and unnecessarily prevents general
> support of ->huge_fault by filesystems. Allow returning "true" if such
> a handler exists, giving the fault path an opportunity to exercise it.
> 
> Similarly, the rationale for including the VM_NO_KHUGEPAGED check
> along the fault path was that it didn't alter any in-tree users, but
> was likewise similarly unnecessarily restrictive (and reads odd).
> Remove the check from the fault path."
>


Any chance this can make it to 6.6 kernel ?

- Saurabh 
