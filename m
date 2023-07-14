Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82831753A71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjGNMNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjGNMNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD722722;
        Fri, 14 Jul 2023 05:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE60061CF8;
        Fri, 14 Jul 2023 12:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC74AC433C7;
        Fri, 14 Jul 2023 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689336809;
        bh=mWkDHkZl+VbW8o1b0RsUyRG5AF0ByNkcZoOfPpiApzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuZ0XE83FMN9J4tSNwzLvCgw9ZnbZX4PPYRV2GO/4qxffRYC/DTawTyW2ZM+NjFuJ
         xXBIUckgA3xiUQWUyXbdvU8McH2xv1sKdMmRe2yWLzPaJm9ByFyI6nKbPBpiNFNcFP
         3hqz2S96Y0iDWCGl8nZ/32fQoC0KC8MwyPM8U2tLelX7b24oGzAMRpapLuOYKUKkx3
         DZLb1d3KI71CtsEXOBSWKiwO+s6GtvkfzeQqi6s7lj9wMysXeikNmU1KPZbKaOhsFP
         yP+FEXRSW1dPIAV11cJBZJ2v0hIv9sJahFoYLpfoUoOwxmOR488n8kHm+Fr7Z0P2ut
         Rix5WH98gEW2Q==
Date:   Fri, 14 Jul 2023 13:13:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, qperret@google.com
Subject: Re: [PATCH v13 10/24] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230714121321.GB5597@willie-the-truck>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-11-quic_eberman@quicinc.com>
 <20230519115948.GB2637@willie-the-truck>
 <e22c31bd-10ed-f242-3e72-debf40e01e3c@quicinc.com>
 <20230605141839.GD21212@willie-the-truck>
 <3bd86221-ee2e-d157-009b-11f6ada98537@quicinc.com>
 <eae302ab-b508-cdc6-847f-dff6a6b82798@quicinc.com>
 <04605642-cad8-1701-ff41-63f2f00ba5f6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04605642-cad8-1701-ff41-63f2f00ba5f6@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:28:34PM -0700, Elliot Berman wrote:
> On 6/22/2023 4:56 PM, Elliot Berman wrote:
> > On 6/7/2023 8:54 AM, Elliot Berman wrote:
> > > On 6/5/2023 7:18 AM, Will Deacon wrote:
> > > > On Fri, May 19, 2023 at 10:02:29AM -0700, Elliot Berman wrote:
> > > > > The user interface design for *shared* memory aligns with
> > > > > KVM_SET_USER_MEMORY_REGION.
> > > > 
> > > > I don't think it does. For example, file mappings don't work (as above),
> > > > you're placing additional rlimit requirements on the caller, read-only
> > > > memslots are not functional, the memory cannot be swapped or migrated,
> > > > dirty logging doesn't work etc. pKVM is in the same boat, but that's why
> > > > we're not upstreaming this part in its current form.
> > > > 
> > > 
> > > I thought pKVM was only holding off on upstreaming changes related
> > > to guest-private memory?
> > > 
> > > > > I understood we want to use restricted memfd for giving
> > > > > guest-private memory
> > > > > (Gunyah calls this "lending memory"). When I went through
> > > > > the changes, I
> > > > > gathered KVM is using restricted memfd only for
> > > > > guest-private memory and not
> > > > > for shared memory. Thus, I dropped support for lending
> > > > > memory to the guest
> > > > > VM and only retained the shared memory support in this
> > > > > series. I'd like to
> > > > > merge what we can today and introduce the guest-private
> > > > > memory support in
> > > > > tandem with the restricted memfd; I don't see much reason to delay the
> > > > > series.
> > > > 
> > > > Right, protected guests will use the new restricted memfd ("guest mem"
> > > > now, I think?), but non-protected guests should implement the existing
> > > > interface *without* the need for the GUP pin on guest memory pages. Yes,
> > > > that means full support for MMU notifiers so that these pages can be
> > > > managed properly by the host kernel. We're working on that for pKVM, but
> > > > it requires a more flexible form of memory sharing over what we
> > > > currently
> > > > have so that e.g. the zero page can be shared between multiple entities.
> > > 
> > > Gunyah doesn't support swapping pages out while the guest is running
> > > and the design of Gunyah isn't made to give host kernel full control
> > > over the S2 page table for its guests. As best I can tell from
> > > reading the respective drivers, ACRN and Nitro Enclaves both GUP pin
> > > guest memory pages prior to giving them to the guest, so I don't
> > > think this requirement from Gunyah is particularly unusual.
> > > 
> > 
> > I read/dug into mmu notifiers more and I don't think it matches with
> > Gunyah's features today. We don't allow the host to freely manage VM's
> > pages because it requires the guest VM to have a level of trust on the
> > host. Once a page is given to the guest, it's done for the lifetime of
> > the VM. Allowing the host to replace pages in the guest memory map isn't
> > part of any VM's security model that we run in Gunyah. With that
> > requirement, longterm pinning looks like the correct approach to me.
> 
> Is my approach of longterm pinning correct given that Gunyah doesn't allow
> host to freely swap pages?

No, I really don't think a longterm GUP pin is the right approach for this.
GUP pins in general are horrible for the mm layer, but required for cases
such as DMA where I/O faults are unrecoverable. Gunyah is not a good
justification for such a hack, and I don't think you get to choose which
parts of the Linux mm you want and which bits you don't.

In other words, either carve out your memory and pin it that way, or
implement the proper hooks for the mm to do its job.

Will
