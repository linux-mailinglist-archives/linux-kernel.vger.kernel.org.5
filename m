Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B37DFBB4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjKBUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:49:28 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D40184;
        Thu,  2 Nov 2023 13:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=O7iSBn9AfkPqt/uSYK72qO1u/XTtah1iL+HToWOURDc=; b=YpkzWybdPpo8ZX7oJE/mF6Nbu0
        dyDdnFsJKnhYD49Nx1qhK3HZijqyiAnV8iaIFkS2P7VIhVaIiyW8ueF3Er0FA5nmvlXAMGgpktc2W
        XYf5GO5cw6ioWlbKhJDDG+l8PCGaiRg56vojVSa9KetVIAO6PKcuEgAVq9/PlNvrtjyaXz2at1COp
        glnk6qkGv95IqAfaXB/aotr+RckKY/bWWItf26fcETTizJ5R8TtH9s/heXFxYN8aWOe/06BlPGDuD
        2k6wPuupOlxsH3MjX1/Uun31YzrE5VhlNC8wX8goOvwzDEjGanI9+D46isjSDimArp5XwopNzJJX+
        A+nGzYjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyech-009x1D-2S;
        Thu, 02 Nov 2023 20:49:03 +0000
Date:   Thu, 2 Nov 2023 20:49:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Airlie <airlied@redhat.com>
Cc:     Philipp Stanner <pstanner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] drivers/tty/vt: copy userspace arrays safely
Message-ID: <20231102204903.GM1957730@ZenIV>
References: <20231102192134.53301-2-pstanner@redhat.com>
 <20231102201424.GL1957730@ZenIV>
 <CAMwc25rgdNt3oO3Yf=v05AWOSgN5W4j=ST=Y9qikeBrNTqqW2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMwc25rgdNt3oO3Yf=v05AWOSgN5W4j=ST=Y9qikeBrNTqqW2w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 06:24:09AM +1000, David Airlie wrote:
> On Fri, Nov 3, 2023 at 6:14 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Nov 02, 2023 at 08:21:35PM +0100, Philipp Stanner wrote:
> > > The functions (v)memdup_user() are utilized to copy userspace arrays.
> > > This is done without overflow checks.
> > >
> > > Use the new wrappers memdup_array_user() and vmemdup_array_user() to
> > > copy the arrays more safely.
> >
> > > @@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
> > >       if (!ct)
> > >               return 0;
> >
> > > -     unilist = vmemdup_user(list, array_size(sizeof(*unilist), ct));
> > > +     unilist = vmemdup_array_user(list, ct, sizeof(*unilist));
> > >       if (IS_ERR(unilist))
> > >               return PTR_ERR(unilist);
> >
> > a 16bit value times sizeof(something).
> 
> So since it's already using array_size here, moving it to a new helper
> for consistency just makes things clearer, and so you are fine with
> the patch?

Sigh...  OK, if you want it spelled out, there we go.  I have no objections
to the contents of patches; e.g. in case of ppp ioctl it saves the reader
a grep in search of structure definitions, which is a good thing.  The one
and only suggestion I have for those patches is that such patches might be
better off with explicit "in this case the overflow is avoided due to
<reasons>, but use of this helper makes it obviously safe" - or, in case
of real bugs, "the overflow is, indeed, possible here", in which case
Fixes: ... and Cc: stable might be in order.
