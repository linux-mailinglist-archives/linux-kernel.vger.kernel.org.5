Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895097F8986
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjKYJVj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Nov 2023 04:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKYJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:21:33 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADA610CA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 01:21:40 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc41aed6a5so29475415ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 01:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700904100; x=1701508900;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEGqev8W91UlLE+z9Vq14xAa3OdBqUjqhjL3kWN4G7A=;
        b=DAxqV0adQIx0K7Zp4R0CV5SMouOac1kFzQnwz1aDzZAiRKq14AhCfbsdrlTyr0ncU6
         s6yGm3tbhfEOqgVjXfwgNCSbVDKbiEjqo68+hY/1NWbIpd0+zw1DjcT5ioAxPP++fk6E
         AUDypTmhliVhmWmnZpi8SbRzH5yethV0WHwIumucBUFJ2rrshViJSeLZPNHPGwKD+bz1
         iNTCB1iIh9ErE8LpZEIBqIxa9quOeHV7oV22iPn+v2kpiCauwr0CmPPJzAleuQTjfZfA
         KAp/2RnY8kImetlrwwTp9lo456J0MfxnsJgyiswnqz5zu6/bRFpD6IhNTs0hUgUOng1c
         Ul4w==
X-Gm-Message-State: AOJu0YzY0eYpIUF0Q3/wPtUldJAlrlj2HAYoYQXO41uuND+/0X+aQ34E
        VbB3Go8MTjLT9sLQCKUvaanAF5V8S28feUgf1TRtNVKHWOe4
X-Google-Smtp-Source: AGHT+IGPVstb3OhDXZAiIYvNNdhtJBX1C3jCTeiOfdWwIX8+PfsQoQlSvWiiJmnGHUXmFN+KLYsjmuugDSZkVe13jMG/FM1hOsdm
MIME-Version: 1.0
X-Received: by 2002:a17:902:e88f:b0:1c9:c879:ee82 with SMTP id
 w15-20020a170902e88f00b001c9c879ee82mr1201359plg.11.1700904099848; Sat, 25
 Nov 2023 01:21:39 -0800 (PST)
Date:   Sat, 25 Nov 2023 01:21:39 -0800
In-Reply-To: <CAOQ4uxj+enOZJiAJaCRnfb1soFS7aonJjHmLXiP3heQAFQoBqg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab2787060af698fc@google.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in ovl_copy_up_one
From:   syzbot <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com>
To:     amir73il@gmail.com
Cc:     amir73il@gmail.com, jannh@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 24, 2023 at 5:26 PM Jann Horn <jannh@google.com> wrote:
>>
>> On Fri, Nov 24, 2023 at 4:11 PM Jann Horn <jannh@google.com> wrote:
>> >
>> > On Wed, Sep 27, 2023 at 5:10 PM syzbot
>> > <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com> wrote:
>> > > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>> > >
>> > > Reported-and-tested-by: syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com
>> > >
>> > > Tested on:
>> > >
>> > > commit:         8e9b46c4 ovl: do not encode lower fh with upper sb_wri..
>> > > git tree:       https://github.com/amir73il/linux.git ovl_want_write
>> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10d10ffa680000
>> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=bb54ecdfa197f132
>> > > dashboard link: https://syzkaller.appspot.com/bug?extid=477d8d8901756d1cbba1
>> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> >
>> > It looks like the fix was submitted without the Reported-by tag, so
>> > syzkaller doesn't recognize that the fix has landed... I'll tell
>> > syzkaller now which commit the fix is supposed to be in, please
>> > correct me if this is wrong:
>> >
>> > #syz fix: ovl: do not encode lower fh with upper sb_writers held
>>
>> (Ah, and just for the record: I hadn't realized when writing this that
>> the fix was actually in a newer version of the same patch... "git
>
> That is correct.
> I am very thankful for syzbot with helping me catch bugs during development
> and I would gladly attribute the bot and its owners, but I don't that
> Reported-and-tested-by is an adequate tag for a bug that never existed as
> far as git history.
>
> Even Tested-by: syzbot could be misleading to stable kernel bots
> that may conclude that the patch is a fix that needs to apply to stable.
>
> I am open to suggestions.
>
> Also maybe
>
> #syz correction:

unknown command "correction:"

>
> To tell syzbot we are not fixing a bug in upstream, but in a previous
> version of a patch that it had tested.
>
>> range-diff 44ef23e481b02df2f17599a24f81cf0045dc5256~1..44ef23e481b02df2f17599a24f81cf0045dc5256
>> 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77~1..5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77"
>> shows an added "ovl_get_index_name", I guess that's the fix?)
>
> No, that added ovl_get_index_name() seems like a fluke of the range-diff tool.
> All the revisions of this patch always had this same minor change in this line:
>
> -               err = ovl_get_index_name(ofs, c->lowerpath.dentry,
> &c->destname);
> +               err = ovl_get_index_name(ofs, origin, &c->destname);
>
> The fix is obviously in the other part of the range-diff.
>
> Thanks,
> Amir.
>
>                 if (err)
>      -                  return err;
>     -+                  goto out;
>     ++                  goto out_free_fh;
>         } else if (WARN_ON(!c->parent)) {
>                 /* Disconnected dentry must be copied up to index dir */
>      -          return -EIO;
>      +          err = -EIO;
>     -+          goto out;
>     ++          goto out_free_fh;
>         } else {
>                 /*
>                  * Mark parent "impure" because it may now contain non-pure
>     @@ fs/overlayfs/copy_up.c: static int ovl_do_copy_up(struct
> ovl_copy_up_ctx *c)
>                 ovl_end_write(c->dentry);
>                 if (err)
>      -                  return err;
>     -+                  goto out;
>     ++                  goto out_free_fh;
>         }
>
>         /* Should we copyup with O_TMPFILE or with workdir? */
>     @@ fs/overlayfs/copy_up.c: static int ovl_do_copy_up(struct
> ovl_copy_up_ctx *c)
>       out:
>         if (to_index)
>                 kfree(c->destname.name);
>     ++out_free_fh:
>      +  kfree(fh);
>         return err;
>       }
