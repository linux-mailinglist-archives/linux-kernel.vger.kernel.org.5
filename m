Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A57EFB27
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjKQWGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjKQWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:06:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A420D4B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:06:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DFDC433C8;
        Fri, 17 Nov 2023 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700258779;
        bh=SP+WuLQJvw8hFCyB/cFybE5MSHrARSN2dACpt4tsxDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdCfz4VOsjHjMTadJ/20j9NRddbDwNOt3TyUk1PO8RDhWWccLdgXkUuj7eR8y/h2/
         ckTHZoVH/NI12KpPLqsYSlwE1IrLMPwfrbDkG6Br0c7vaX9m0+FKrnW3XPFzQQv9WV
         lipJb6DPKn5KZyGeLfmLYevs2/9qgGyy2AqlUQjE=
Date:   Fri, 17 Nov 2023 17:06:16 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Xu Yilun <yilun.xu@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <2023111756-geometry-amplifier-38ce@gregkh>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <5c3c3905-67c2-4cc2-8477-c6fc74676fc9@redhat.com>
 <ZVMZZNyLE0+YtKYz@yilunxu-OptiPlex-7050>
 <2b26d45d-7577-4824-bad9-d5c85f5a098a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b26d45d-7577-4824-bad9-d5c85f5a098a@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 10:58:59PM +0100, Marco Pagani wrote:
> 
> 
> On 2023-11-14 07:53, Xu Yilun wrote:
> > On Fri, Nov 10, 2023 at 11:58:37PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2023-11-08 16:52, Xu Yilun wrote:
> >>> On Fri, Nov 03, 2023 at 09:31:02PM +0100, Marco Pagani wrote:
> >>>>
> >>>>
> >>>> On 2023-10-30 09:32, Xu Yilun wrote:
> >>>>> On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
> >>>>>> Remove unnecessary module reference counting from the core components
> >>>>>> of the subsystem. Low-level driver modules cannot be removed before
> >>>>>> core modules since they use their exported symbols.
> >>>>>
> >>>>> Could you help show the code for this conclusion?
> >>>>>
> >>>>> This is different from what I remember, a module cannot be removed when
> >>>>> its exported symbols are being used by other modules. IOW, the core
> >>>>> modules cannot be removed when there exist related low-level driver
> >>>>> modules. But the low-level driver modules could be removed freely
> >>>>> without other protecting mechanism.
> >>>>>
> >>>>
> >>>> My understanding was that we wanted to remove module reference counting
> >>>> from the fpga core and ease it from the responsibility of preventing
> >>>> low-level driver modules from being unloaded. 
> >>>
> >>> FPGA core needs to prevent low-level driver module unloading sometimes,
> >>> e.g. when region reprograming is in progress. That's why we get fpga
> >>> region driver modules & bridge modules in fpga_region_program_fpga().
> >>>
> >>> But we try best to get them only necessary. Blindly geting them all the
> >>> time results in no way to unload all modules (core & low level modules).
> >>>
> >>>>
> >>>> If we want to keep reference counting in the fpga core, we could add a
> >>>> struct module *owner field in the struct fpga_manager_ops (and others
> >>>> core *_ops) so that the low-level driver can set it to THIS_MODULE.
> >>>> In this way, we can later use it in fpga_mgr_register() to bump up the
> >>>
> >>> Yes, we should pass the module owner in fpga_mgr_register(), but could
> >>> not bump up its refcount at once.
> >>>
> >>>> refcount of the low-level driver module by calling
> >>>> try_module_get(mgr->mops->owner) directly when it registers the manager.
> >>>> Finally, fpga_mgr_unregister() would call module_put(mgr->mops->owner)
> >>>> to allow unloading the low-level driver module.
> >>>
> >>> As mentioned above, that makes problem. Most of the low level driver
> >>> modules call fpga_mgr_unregister() on module_exit(), but bumping up
> >>> their module refcount prevents module_exit() been executed. That came
> >>> out to be a dead lock.
> >>>
> >>
> >> Initially, I considered calling try_module_get(mgr->mops->owner)
> >> in fpga_mgr_get(). But then, the new kernel-doc description of
> >> try_module_get() (1) made me question the safety of that approach.
> >> My concern is that the low-level driver could be removed right when
> >> someone is calling fpga_mgr_get() and hasn't yet reached
> >> try_module_get(mgr->mops->owner). In that case, the struct mops
> >> (along with the entire low-level driver module) and the manager dev
> >> would "disappear" under the feet of fpga_mgr_get().
> > 
> > I don't get what's the problem. fpga_mgr_get() would first of all
> > look for mgr_dev via class_find_device(), if low-level module is
> > unloaded, then you cannot find the mgr_dev and gracefully error out.
> > 
> > If class_find_device() succeed, mgr_dev got a reference and won't
> > disappear. Finally we may still found module removed when
> > try_module_get(), but should be another graceful error out.
> > 
> > Am I missing anything?
> > 
> 
> My concern is: suppose that you successfully got the mgr dev from
> class_find_device(), and now you are in __fpga_mgr_get(), right before
> try_module_get(mgr->mops->owner). At that point, you get descheduled,
> and while you are not running, someone unloads the low-level driver
> module that ends its life by calling fpga_mgr_unregister(). When you
> wake up, you find yourself with a reference to a device that does not
> exist anymore, trying to get a module that does not exist anymore
> through one of its symbols (module *owner in mops).

Then the user gets to keep the multiple pieces that their kernel is now
in :)

Seriously, as module unload can never happen except by explicit ask,
this should only possibly be an issue that a developer who is working on
the code would hit, so don't work too hard to resolve something that
isn't anything an actual user can hit.

> Greg suggested checking if this can really happen and eventually
> protecting fpga_mgr_get() and fpga_mgr_unregister() with a lock for
> mops (if I understood correctly). In that case, considering the same
> scenario described above:
> 
> fpga_mgr_get() gets the mops lock and the mgr dev but is suspended
> before calling try_module_get().
> 
> Someone unloads the low-level driver, delete_modules progresses
> (the module's recount hasn't yet been incremented) but blocks while
> calling fpga_mgr_unregister() since fpga_mgr_get() is holding the lock.
> 
> fpga_mgr_get() resumes and tries to get the module through one of its
> symbols (mgr->mops->owner). The module's memory hasn't yet been freed
> (delete_modules is blocked), and the refcount is zero, so
> try_module_get() fails safely, and we can put the mgr dev that is
> still present since fpga_mgr_unregister() is blocked.
> 
> fpga_mgr_unregister() resumes and unregisters the mgr dev.

That seems a bit reasonable, try it and see!

> I'm still thinking about the possible implications. On the one hand,
> it looks safe in this case, but on the other hand, it feels brittle.
> In my understanding, the root problem is that there will always be a
> critical window (when you have taken a reference to the device but
> not yet to the low-level driver module) when unloading the module
> could be potentially unsafe depending on the current implementation
> and the preemption model.
> 
> I still feel that it would be simpler and safer if we could bump
> up the refcount during fpga_mgr_register() and maybe have a sysfs
> attribute to unlock the low-level driver (if no one has taken the
> mgr dev refcount).

Ick, no, that shouldn't be needed.

> That way, it would be safer by design since the
> refcount will be bumped up right during the module load procedure,
> and we could guarantee that the lifetime of the mgr device is
> entirely contained in the lifetime of the low-level driver module.

Remember, there are two different things here, code and data.  Trying to
tie one ref count to the other is almost always going to cause problems,
try to keep them independent if at all possible.

Or better yet, just don't use module reference counts at all and
properly drop the device when the specific module is unloaded, like
network drivers do.  That might take more work to restructure things,
which might be useless work given that again, this is something that no
user will ever hit, only developers if at all.

thanks,

greg k-h
