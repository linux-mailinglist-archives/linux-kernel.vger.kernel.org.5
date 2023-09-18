Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83C7A4ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjIRQ1E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 12:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIRQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:26:30 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9227226685
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:22:53 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id CF3051C9E44;
        Mon, 18 Sep 2023 16:22:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 383CB2002B;
        Mon, 18 Sep 2023 16:22:48 +0000 (UTC)
Message-ID: <1bed972eb2fb1dc305e5da9a75542558bbe6e13e.camel@perches.com>
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Pearson <mpearson-lenovo@squebb.ca>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Sep 2023 09:22:47 -0700
In-Reply-To: <ZQhg+Hcv4QHGJ3+s@smile.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
         <20230906121328.50437-1-mpearson-lenovo@squebb.ca>
         <ZQhXZkBHviGOEl-x@smile.fi.intel.com>
         <878da778-e183-6ef5-61ce-3a3d059f1a1e@redhat.com>
         <ZQhg+Hcv4QHGJ3+s@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: zdejjwn5y5o7datxjjyyqneonna6xmfa
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=1.0 required=5.0 tests=FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Queue-Id: 383CB2002B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18IIPdAe/d0R+ZzEM+uijFVzoWhM8KY5sM=
X-HE-Tag: 1695054168-795019
X-HE-Meta: U2FsdGVkX19KwzESdQyEVfr0h4yR2WFVwjXCedSSF4nzJW6icAqQ8Shw1ThHdgG+wjzVK2KL/ZymjMsWkDjdwQ+YHjNsw/nB/IwwMTgEzG0gZVNz09x4STXBIyePH7ZXIzME96RXunNzAc54qx8rVGq1IfUs8cn3aZwn3FM3ZLUyQ41im+6SOwGD4svfD2A5oLxA1Ya4RdW8rTM8f/kLGGysev6w6TBJbnzFcT53CbneMp+SgLqcihEw+CB8pmPG1iF1NCOp0DEuT6vvX2aFWxwH9e0HZy3i/4HIfn0uVIdN5YnfyLbvXMWHxTh/PYAv
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-18 at 17:38 +0300, Andy Shevchenko wrote:
> On Mon, Sep 18, 2023 at 04:07:53PM +0200, Hans de Goede wrote:
> > On 9/18/23 15:57, Andy Shevchenko wrote:
> > > On Wed, Sep 06, 2023 at 08:13:14AM -0400, Mark Pearson wrote:
> 
> ...
> 
> > > > +/* There are a limit on the number of WMI operations you can do if you use
> > > > + * the default implementation of saving on every set. This is due to a
> > > > + * limitation in EFI variable space used.
> > > > + * Have a 'bulk save' mode where you can manually trigger the save, and can
> > > > + * therefore set unlimited variables - for users that need it.
> > > > + */
> > > 
> > > /*
> > >  * This is wrong multi-line comment style. This one
> > >  * is used solely in net subsystem.
> > >  */
> > 
> > Good catch, Mark can you fix this one too please ?
> > 
> > Also I thought that checkpatch.pl used to catch this ?
> 
> I don't think it recognizes "net style is only for net related files".

It doesn't as there are just too many of them.


