Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0CF7BF51B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442677AbjJJH7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442658AbjJJH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:59:24 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F2AC;
        Tue, 10 Oct 2023 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=vZ/Iuu84hep1RjBDXaiCtQLKdDGxvE+knWVOSwSOFmg=; b=YzZE4smWZ+q1Mv7lXM23xEuJHM
        ZP7WoGJCARna5evriYPQuoydFF0clnT/ChUm0MTeGEUNK15U5UXFt8o+INlOw8DimXlAxraQv7Mzy
        6uFAF1ts4lE6i46Rt6eOYHYtw6s7lhmv+tvyxFdZ+IaJe3IgBZqP6lzaHlBnQ7z6HPBiSN9g2y04x
        6c1yIy6h2MFxa3qarhFqqXcyYHOWXcnsCG0P3Ztv3iNTK+jVdx2eWIj8xmiRq9t6FXTDWq6yq01wX
        kmrqCZpSZXxeDHFjHUo/l3RIdjvdupSYF0V6hZ39d6w4q1jGq0A/diV7mbm4EhU/F5YJQuIoZVTkJ
        YZnO8kZiyUfmiKR4Hl8XHbYx3oIvm+TDZIqDdfMYnPGx+0bybv+4FihZ2fxIjyaU9zgUg3f1hs9Td
        PbohF7ljIpr7/U6tdJY3wSV72clciralsqhHOzcggHjGBNEGKTiRcweeUnRJvhThvOgbeyFqKZEGB
        cLLbrrOdjR5MGW9L3Yd+BlJ7aEL0kGjZl7L4JF74qsh/aGHL41rsYW0VZNKyjW39fEc7MEaI+KklP
        tKA5a8O2lwqqoRLBWhHXEbD3NHWYQWhMle4gqLJh3Me5Yu0rb76vU4aMKOTuAiTvP5PuqU4rIn0Xv
        OlhzQo8VRUFFTnoDV/t0p0Tx+ZBUDK10hMeH+T5vo=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     asmadeus@codewreck.org
Cc:     ericvh@kernel.org, lucho@ionkov.net, Su Hui <suhui@nfschina.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Date:   Tue, 10 Oct 2023 09:59:11 +0200
Message-ID: <1795281.aKYqWbn8Tv@silver>
In-Reply-To: <ZSS1irFMxC35cg01@codewreck.org>
References: <20231008060138.517057-1-suhui@nfschina.com> <13910281.Zj71IQSfG8@silver>
 <ZSS1irFMxC35cg01@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 10, 2023 4:23:06 AM CEST asmadeus@codewreck.org wrote:
> Christian Schoenebeck wrote on Mon, Oct 09, 2023 at 08:34:15PM +0200:
> > > +++ b/fs/9p/xattr.c
> > > @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
> > >  
> > >  ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
> > >  {
> > > -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
> > > +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
> > >  }
> > >  
> > >  static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
> > > 
> > 
> > Mmm, that's not the same is it? Have you tested this change?
> > 
> > Currently this function causes a 'Txattrwalk' 9p message to be sent to 9p
> > server with its name[s] field being NULL, and the latter being the magical
> > hint to 9p server to not send an attribute, but rather the list of attributes.
> > 
> > With your change I would assume that it would rather ask server for one
> > attribute called "". I have not tested myself, just worrying that it might
> > break behaviour.
> 
> p9pdu_vwritef should output the same (just a 0 length) for both NULL and
> "" so I think it should be ok, but it definitely needs testing.
> 
> I'll try to find time to check (getfattr -d should be enough) later this
> week and add it to the pile

Yeah, I think you are right Dominique, it should end up the same as both cases
result in a string length of 0.

/Christian


