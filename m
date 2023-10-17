Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211467CC5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbjJQOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbjJQOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBBFE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697551904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWjusTAfFAOYOcD/DhpPcW94Ds/LtAztiDTrje2s98g=;
        b=MAVZDhVs2CCCBSyQh9tZX4Mw76tJ0lYAZJHm9xtESteQoRA14L9Pmp3K2iAJfeaDW4/U/x
        tTxmfzMNbhP8J0O9jevCHNxOLphxCiN6WrLFe4QBJ/xKFUkhTPNG9/547FMuQI1ixmZ1v6
        ieljO8xDNp8j1fr97wD33Bq6I4AYOwE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-JTdBv1LlNsiwPxbbUHanwg-1; Tue, 17 Oct 2023 10:11:42 -0400
X-MC-Unique: JTdBv1LlNsiwPxbbUHanwg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d12cd3591so48675336d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551900; x=1698156700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWjusTAfFAOYOcD/DhpPcW94Ds/LtAztiDTrje2s98g=;
        b=hlmcyL/bLIuKi7NGU3k9YWtw5x6mgwPcVNzjz2prodS87adHraWN8gy2oSf4H7CbeY
         0GQ+IpGA4l713RrwZD0gAfwOToLNgWButLUIlknbALNAh6NISjq4Ew/QnPQDuC+L2TWQ
         1ynTL9B0uZGTLOWxxCeaxesuj8nzWAkNbO05UiXu81/Nwf7P/7qV/WNpPpSgkmHsSm3w
         IHSrfHiaCfIwXM+iiZMnoniU3QX9k7w59WIlhQDdTsDl5C/U6CsRNCDKRQ3R5uggs6Y4
         h0yDaCtBG3lMJd4c0/JlR0FtxyJPmtyY34E0UmR5FvlquNAcg8zZkisjR0DY+nqBEtoH
         yj6A==
X-Gm-Message-State: AOJu0YzOSrWOmHATLvejlY0bY9uN3taeErfQSe9BPyfBfkQgt2m8PvQm
        uc1mV/LYSzImmPUboXNhzjFrLGOdd5HuZl0U38X0UtKJhCVo77Nv7RpJFBmC6R//P8cWLQqqH+m
        g3eXT6dfJa0CPbQjaNbAdZY9a
X-Received: by 2002:a05:6214:da7:b0:66d:6667:deab with SMTP id h7-20020a0562140da700b0066d6667deabmr2987439qvh.35.1697551900037;
        Tue, 17 Oct 2023 07:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaov+EHfdufc+0uU9wJyHBemkRgREA1JH9A+Yv3c96V2jcir7c3rBMBtVmswOhzo5W96Xjnw==
X-Received: by 2002:a05:6214:da7:b0:66d:6667:deab with SMTP id h7-20020a0562140da700b0066d6667deabmr2987415qvh.35.1697551899738;
        Tue, 17 Oct 2023 07:11:39 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id dl8-20020ad44e08000000b006577e289d37sm583566qvb.2.2023.10.17.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:11:39 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:12:05 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <ZS6WNXABUDTh8NZA@bfoster>
References: <20231010235609.work.594-kees@kernel.org>
 <ZSkpU0vdrCTfTxuZ@bfoster>
 <202310131637.D0C66BFBA@keescook>
 <ZS0vlpSwH1+/+EVM@bfoster>
 <202310161249.43FB42A6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310161249.43FB42A6@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:18:19PM -0700, Kees Cook wrote:
> On Mon, Oct 16, 2023 at 08:41:58AM -0400, Brian Foster wrote:
> > On Fri, Oct 13, 2023 at 04:44:21PM -0700, Kees Cook wrote:
> > > On Fri, Oct 13, 2023 at 07:26:11AM -0400, Brian Foster wrote:
> > > > On Tue, Oct 10, 2023 at 04:56:12PM -0700, Kees Cook wrote:
...
> > > > 
> > > > Hi Kees,
> > > > 
> > > > I'm curious if this is something that could be buried in bch_val given
> > > > it's already kind of a fake structure..? If not, my only nitty comment
> > > 
> > > I was thinking it would be best to keep the flexible array has "high" in
> > > the struct as possible, as in the future more refactoring will be needed
> > > to avoid having flex arrays overlap with other members in composite
> > > structures. So instead of pushing into bch_val, I left it at the highest
> > > level possible, bch_i, as that's the struct being used by the memcpy().
> > > 
> > > Eventually proper unions will be needed instead of overlapping bch_i
> > > with other types, as in:
> > > 
> > > struct btree_root {
> > >         struct btree            *b;
> > > 
> > >         /* On disk root - see async splits: */
> > >         __BKEY_PADDED(key, BKEY_BTREE_PTR_VAL_U64s_MAX);
> > >         u8                      level;
> > >         u8                      alive;
> > >         s8                      error;
> > > };
> > > 
> > > But that's all for the future. Right now I wanted to deal with the more
> > > pressing matter of a 0-sized array not being zero sized. :)
> > > 
> > 
> > Ok, but I'm not really following how one approach vs. the other relates
> > to this particular example of an embedded bkey_i. I'm probably just not
> > familiar enough with the current issues with 0-sized arrays and the
> > anticipated path forward. Can you elaborate for somebody who is more
> > focused on trying to manage the design/complexity of these various key
> > data structures? For example, what's the practical difference here (for
> > future work) if the flex array lives in bch_val vs. bkey_i?
> 
> I was looking strictly at the layer it was happening: the function that
> calls memcpy() is working on a bkey_i, so I figured that was the place
> for it currently.
> 
> > Note that I don't necessarily have a strong opinion on this atm, but if
> > there's a "for future reasons" aspect to this approach I'd like to at
> > least understand it a little better. ;)
> 
> The future work here is about making sure flexible arrays don't overlap
> with non-flexible array members[1], and that will require giving some
> thought to how the structures are arranged.
> 
...
> The use of "struct header" effectively says "we have some number of bytes,
> but we don't know *what* it is yet". Is it cmd_one, or cmd_two? Instead
> of combining the flex array with the header, we can either split it off:
> 
> struct header {
> 	u32 long flags;
> 	struct other things;
> 	size_t byte_count;
> };
> 
> struct cmd_unknown {
> 	struct header;
> 	u8 bytes[];
> };
> 
> Or we can merge all the structs together:
> 
> struct everything {
> 	u32 long flags;
> 	struct other things;
> 	size_t byte_count;
> 	union {
> 		struct cmd_one {
> 			u64 detail;
> 			u8 bits;
> 		};
> 		struct cmd_two {
> 			u32 foo, bar;
> 			u64 baz;
> 		};
> 		struct unknown {
> 			u8 bytes[];
> 		};
> 	};
> };
> 
> In the first style, the flexible array is distinctly separate. In the
> second style the overlap is explicitly shown via the union.
> 
> I expect it will take a long time to make the kernel "flex array overlap
> clean", so while I don't feel any rush, I've been generally trying to
> avoid seeing new instances of ambiguous overlap _added_ to the kernel. :)
> 

Got it. This helps explain potential wonkiness of a variant with the
flex array buried in bch_val.

> bcachefs is in a unique places where because it's been out of tree
> its code patterns aren't "new", but it's just been "added" upstream.
> *shrug* So we'll deal with the existing warnings we've already got,
> and prepare for the future warnings as we can.
> 

Ack.

> Hopefully that helps!
> 

Indeed it does, thanks!

Brian

> -Kees
> 
> [1] See "-Wflex-array-member-not-at-end":
>     https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] Going all the way back to 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> > 
> > > > is that memcpy(k->bytes[], ...) makes it kind of read like we're copying
> > > > in opaque key data rather than value data, so perhaps a slightly more
> > > > descriptive field name would be helpful. But regardless I'd wait until
> > > > Kent has a chance to comment before changing anything..
> > > 
> > > How about "v_bytes" instead of "bytes"? Or if it really is preferred,
> > > I can move the flex array into bch_val -- it just seems like the wrong
> > > layer...
> > > 
> > 
> > Yeah.. v_bytes, value_bytes, etc. etc. Anything that avoids misleading
> > code when using the field is good with me. Thanks.
> > 
> > Brian
> > 
> > > -Kees
> > > 
> > > > 
> > > > Brian
> > > > 
> > > > >  
> > > > >  #define KEY(_inode, _offset, _size)					\
> > > > > diff --git a/fs/bcachefs/extents.h b/fs/bcachefs/extents.h
> > > > > index 7ee8d031bb6c..6248e17bbac5 100644
> > > > > --- a/fs/bcachefs/extents.h
> > > > > +++ b/fs/bcachefs/extents.h
> > > > > @@ -642,7 +642,7 @@ static inline void bch2_bkey_append_ptr(struct bkey_i *k, struct bch_extent_ptr
> > > > >  
> > > > >  		ptr.type = 1 << BCH_EXTENT_ENTRY_ptr;
> > > > >  
> > > > > -		memcpy((void *) &k->v + bkey_val_bytes(&k->k),
> > > > > +		memcpy(&k->bytes[bkey_val_bytes(&k->k)],
> > > > >  		       &ptr,
> > > > >  		       sizeof(ptr));
> > > > >  		k->k.u64s++;
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > > 
> > > 
> > > -- 
> > > Kees Cook
> > > 
> > 
> 
> -- 
> Kees Cook
> 

