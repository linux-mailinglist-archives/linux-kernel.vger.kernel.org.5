Return-Path: <linux-kernel+bounces-128406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DA895A68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8412A281279
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD8159916;
	Tue,  2 Apr 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELw2t40z"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD0132C38
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077749; cv=none; b=DaKNNZbvnW3zuJVgq0tqAME336NviDzIIvQAGzly5SyR47ABqcHDca3+ZPJ+gUNFhj185ieq76BekKYWe+4ShbbjVGC6UqzMDIhYCjAnMZmpFrXnQQ0ggzCwyTyo5l1o/q5VMaFzqGXf81cGf0QVWWtkyxQTAIPhNU0TpeIPk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077749; c=relaxed/simple;
	bh=IKt3lo/htxFaVYMCmtSeXuUUKW1gUFfAxR/9OMSoD9A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t12RROgfKZiG8sv5UmDoubsL8qCW5yAv6COiQ8qeu8xgo967IZ1cGISZ/m1bsOg//1amPGlJQnLSNrq3MTGmw9MdY2XsXpcdgsVLG4p/mx1g6+JTFa2alC407tTKLZIDm8fUYUacmyi453KsThZByrViLQlnYh/cSgYtoNgA5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELw2t40z; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6098a20ab22so47549797b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712077746; x=1712682546; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=faGsxrxfxhCbajyESqHsH8e/i4IjraIx5QTZl/zDAdU=;
        b=ELw2t40zD7gCXXnKYJ1JA5xgxJn9tjCbqLoa4ssgaMMdUMdMVFULWRoanGBRI+1a6O
         kyHupDw7RqIHLwLjR/2N20XTfoySHeAYZ2OrElx+bGpDu/ADdZGGn0EmJYNi29xVOz6A
         Aj5xn4XbggcPPAjEaGQ27fZ0m3ZjyVqwKFiUKslmT4HpI+QdlxlGvXAiD6T/wCMkOqZz
         SeUngwfkpvIdwbHdIMeEXoLTIGdKPzR99aCmL9qb/q8csXvgRVTjKA0qbx/MFWaTn5gx
         betDNubMSiap1hbFTUFw0eCuJEJ576CpQDh92+OecWkFVYVeGk6/tRXBt+KeF7aYsf5P
         nZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712077746; x=1712682546;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faGsxrxfxhCbajyESqHsH8e/i4IjraIx5QTZl/zDAdU=;
        b=OfzO01Q+8vivTaTNphZCc01q0LhPxZ/iY2CG80EQUhtGc8WjZ9g62go0/whnYLx5n9
         Ve0gqemrD44R15vQjF00rR7twb6uZhgRjPJ3rJrAHzonGNhvjvp+q+UPuOG1MAH+dF0P
         1suy9Jtg7PGMfI8FzCwhzl5LlUieEs+2/A3ZLBfPsViE91DjKRSpPTsiyLbhZF2xYXal
         f3d1zHOho5DrV6dTwqu7ZXPXaXbVjyiqjTYcl9AJlLwKC7SEgufDpDxo90jtM6Cf0YfW
         tssVSbrlapS29AtDCXeuFoTRIiiGd0nOdoJwreP2FiW/ou3NVFOFG8yu0MBwea0YHLkr
         iizw==
X-Gm-Message-State: AOJu0Yzr2Ta5a2pdsDLZhJpWNyH5T7UEFm0slc5RIwV8o8MIkgXOIf+4
	S+aahfWNMC1+feDyZE/oMBE8KcfY0+UKSo/NqIVR3vl4An3jzAYOimQCc/eFJVNZFvLFBnHbl06
	+JJfPJsm/bVGTiZnKrCqhzO70MH8D1o3e7Lg=
X-Google-Smtp-Source: AGHT+IGAdlQCt+KfFgdTxlRdXyIKRWXDPKiQactbyUG2qB9wX1OfpzrGikcNzgFOFRRK4KL/OJsUa3jyx5DMRTvQY7o=
X-Received: by 2002:a0d:eb47:0:b0:615:14d2:945d with SMTP id
 u68-20020a0deb47000000b0061514d2945dmr230180ywe.3.1712077746396; Tue, 02 Apr
 2024 10:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Tue, 2 Apr 2024 11:08:54 -0600
Message-ID: <CAMP44s2=OAmLmoNN1VG7j3783ac9L7mk-4sTpNWA2gtUPHfpAA@mail.gmail.com>
Subject: C skill issues and good taste
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Recently it has been more apparent to me that there is a lot of desire
to learn proper C, and the chasm between beginners and experts is huge.

Linus Torvalds provided an example of what he considered "good taste" in
code for his TED interview in 2016 [1]. I wasn't the only one that found
this example interesting, since Marc Kirchner created an entire project
devoted to explaining this code [2] and why it's good.

I wasn't content with that, and I created yet another project that
ultimately explains intrusive linked lists [3] using code from Linux.

While I'm OK with the end result, I wonder if Linux kernel developers
would agree this is "good taste" code.

I understand that deleting a node in the middle of a singly linked list
is not something that Linux developers would want to do, but this is the
example Torvalds gave, and I would like to show code that does this in a
proper way.

So the following is my version of what llist_del would look like, and in
my opinion the only tricky part is what to do in the case that the entry
to remove is the first node. For that case we need to update the head's
first pointer, but if we consider it a llist_node, it's the same as the
next pointer.

struct llist_node *llist_del(struct llist_head *list, struct llist_node *entry)
{
        struct llist_node *p;

        llist_for_each(p, (struct llist_node *)list) {
                if (p->next != entry) continue;
                p->next = entry->next;
                return entry;
        }

        return NULL;
}

Does this make sense for educational purposes? I'm not expecting this
code to be merged, as I understand deleting a node in the middle of a
single linked list doesn't offer good performance.

But does this explain the point Linus Torvalds was trying to make in the
Ted interview?

Cheers.

[1] https://www.youtube.com/watch?v=o8NPllzkFhE&t=858s
[2] https://github.com/mkirchner/linked-list-good-taste
[3] https://felipec.github.io/good-taste/parts/3.html

-- 
Felipe Contreras

