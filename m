Return-Path: <linux-kernel+bounces-90126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A57C86FAB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2F1C21133
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAFF13AEA;
	Mon,  4 Mar 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="O43rKGW/"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A406290A;
	Mon,  4 Mar 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537107; cv=none; b=lSbUMGpLxNQw6HZJpq/YhFROOcbsCWH8wJtWvjrsjqSbhEuj4fxvNQ3qLL9Dzkv9l26y7EhtZvzmDohMkO9BfLImkgmcz9HfXil/mUmmTgn7ZwyJ0cuAc9NPARi93/+g5yXEU47XBI8BtNYKfs9h2X8Um95u9R+55Go5PL2F5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537107; c=relaxed/simple;
	bh=LitBOrh0rH84Ytd3oX/0/rdi/LDYqoriCLgdKDjvv84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKbC8LEVYgR2Anpdh6oV2nzRkQFrEEvj6XFFFQvG8NE1yNCbt+1EHel0wNAGUUVGXk41VQ7kqdtCIlKwRG7IfyWlD75Q/QzC819WBOa5I5btDEyx7fyV2BcnfULOD5p9MJgPvP5fWOUWvTkzLOG/P0p8JUDdN/BpxAvE8esxCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=O43rKGW/; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [46.242.8.170])
	by mail.ispras.ru (Postfix) with ESMTPSA id 533A140F1DEA;
	Mon,  4 Mar 2024 07:24:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 533A140F1DEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1709537093;
	bh=sUu2jXk6oN7WL3yTZueu0m4/tmU+enR8r/8eii6cirE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O43rKGW/vJhat8eRPnIIhlulsSLV4QuGsTgA4Oz43w2fOcjlK0/EWpbItXaDZ8b9X
	 ACFxcbaPV0PKHeG3aCtbbNW7+f0eu/Mu4CWx31pu2tt2rUBDAxyPVMPxzMoNzobPVh
	 vina/qG8By7JliwbhO27wM2S7zSQlX0RPzBJM8sg=
Date: Mon, 4 Mar 2024 10:24:53 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alexander Aring <aahringo@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: Re: [PATCH wpan] mac802154: fix llsec key resources release in
 mac802154_llsec_key_del
Message-ID: <95eecd55-378c-4a55-96d8-fa74ec59e76a-pchelkin@ispras.ru>
References: <20240228163840.6667-1-pchelkin@ispras.ru>
 <CAK-6q+i4v94uF9BEeZ0zNWtutOn35pzstiY7jMBetCJ0PHOD3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+i4v94uF9BEeZ0zNWtutOn35pzstiY7jMBetCJ0PHOD3w@mail.gmail.com>

Hello Alexander,

Thanks for review!

On 24/03/03 06:19PM, Alexander Aring wrote:
> Hi,
> 
> On Wed, Feb 28, 2024 at 11:44 AM Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> >
> > mac802154_llsec_key_del() can free resources of a key directly without
> > following the RCU rules for waiting before the end of a grace period. This
> > may lead to use-after-free in case llsec_lookup_key() is traversing the
> > list of keys in parallel with a key deletion:
> >
> > refcount_t: addition on 0; use-after-free.
> > WARNING: CPU: 4 PID: 16000 at lib/refcount.c:25 refcount_warn_saturate+0x162/0x2a0
> > Modules linked in:
> > CPU: 4 PID: 16000 Comm: wpan-ping Not tainted 6.7.0 #19
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > RIP: 0010:refcount_warn_saturate+0x162/0x2a0
> > Call Trace:
> >  <TASK>
> >  llsec_lookup_key.isra.0+0x890/0x9e0
> >  mac802154_llsec_encrypt+0x30c/0x9c0
> >  ieee802154_subif_start_xmit+0x24/0x1e0
> >  dev_hard_start_xmit+0x13e/0x690
> >  sch_direct_xmit+0x2ae/0xbc0
> >  __dev_queue_xmit+0x11dd/0x3c20
> >  dgram_sendmsg+0x90b/0xd60
> >  __sys_sendto+0x466/0x4c0
> >  __x64_sys_sendto+0xe0/0x1c0
> >  do_syscall_64+0x45/0xf0
> >  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > Also, ieee802154_llsec_key_entry structures are not freed by
> > mac802154_llsec_key_del():
> >
> > unreferenced object 0xffff8880613b6980 (size 64):
> >   comm "iwpan", pid 2176, jiffies 4294761134 (age 60.475s)
> >   hex dump (first 32 bytes):
> >     78 0d 8f 18 80 88 ff ff 22 01 00 00 00 00 ad de  x.......".......
> >     00 00 00 00 00 00 00 00 03 00 cd ab 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff81dcfa62>] __kmem_cache_alloc_node+0x1e2/0x2d0
> >     [<ffffffff81c43865>] kmalloc_trace+0x25/0xc0
> >     [<ffffffff88968b09>] mac802154_llsec_key_add+0xac9/0xcf0
> >     [<ffffffff8896e41a>] ieee802154_add_llsec_key+0x5a/0x80
> >     [<ffffffff8892adc6>] nl802154_add_llsec_key+0x426/0x5b0
> >     [<ffffffff86ff293e>] genl_family_rcv_msg_doit+0x1fe/0x2f0
> >     [<ffffffff86ff46d1>] genl_rcv_msg+0x531/0x7d0
> >     [<ffffffff86fee7a9>] netlink_rcv_skb+0x169/0x440
> >     [<ffffffff86ff1d88>] genl_rcv+0x28/0x40
> >     [<ffffffff86fec15c>] netlink_unicast+0x53c/0x820
> >     [<ffffffff86fecd8b>] netlink_sendmsg+0x93b/0xe60
> >     [<ffffffff86b91b35>] ____sys_sendmsg+0xac5/0xca0
> >     [<ffffffff86b9c3dd>] ___sys_sendmsg+0x11d/0x1c0
> >     [<ffffffff86b9c65a>] __sys_sendmsg+0xfa/0x1d0
> >     [<ffffffff88eadbf5>] do_syscall_64+0x45/0xf0
> >     [<ffffffff890000ea>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > Handle the proper resource release in the RCU callback function
> > mac802154_llsec_key_del_rcu().
> >
> > Note that if llsec_lookup_key() finds a key, it gets a refcount via
> > llsec_key_get() and locally copies key id from key_entry (which is a
> > list element). So it's safe to call llsec_key_put() and free the list
> > entry after the RCU grace period elapses.
> >
> > Found by Linux Verification Center (linuxtesting.org).
> >
> > Fixes: 5d637d5aabd8 ("mac802154: add llsec structures and mutators")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> > Should the patch be targeted to "net" tree directly?
> >
> >  include/net/cfg802154.h |  1 +
> >  net/mac802154/llsec.c   | 18 +++++++++++++-----
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index cd95711b12b8..76d2cd2e2b30 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h
> > @@ -401,6 +401,7 @@ struct ieee802154_llsec_key {
> >
> >  struct ieee802154_llsec_key_entry {
> >         struct list_head list;
> > +       struct rcu_head rcu;
> >
> >         struct ieee802154_llsec_key_id id;
> >         struct ieee802154_llsec_key *key;
> > diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> > index 8d2eabc71bbe..f13b07ebfb98 100644
> > --- a/net/mac802154/llsec.c
> > +++ b/net/mac802154/llsec.c
> > @@ -265,19 +265,27 @@ int mac802154_llsec_key_add(struct mac802154_llsec *sec,
> >         return -ENOMEM;
> >  }
> >
> > +static void mac802154_llsec_key_del_rcu(struct rcu_head *rcu)
> > +{
> > +       struct ieee802154_llsec_key_entry *pos;
> > +       struct mac802154_llsec_key *mkey;
> > +
> > +       pos = container_of(rcu, struct ieee802154_llsec_key_entry, rcu);
> > +       mkey = container_of(pos->key, struct mac802154_llsec_key, key);
> > +
> > +       llsec_key_put(mkey);
> > +       kfree_sensitive(pos);
> 
> I don't think this kfree is right, "struct ieee802154_llsec_key_entry"
> is declared as "non pointer" in "struct mac802154_llsec_key". The
> memory that is part of "struct ieee802154_llsec_key_entry" should be
> freed when llsec_key_put(), llsec_key_release() hits.
> 
> Or is there something I am missing here?

`struct ieee802154_llsec_key_entry` is not included into any other
struct. It is a standalone entity describing an entry in the
`ieee802154_llsec_table.keys` list.

Maybe you are confusing it with `struct ieee802154_llsec_key`?

When mac802154_llsec_key_add() is called, `struct ieee802154_llsec_key_entry`
objects are allocated using kzalloc() and are linked into the list.

`struct mac802154_llsec_key` object is allocated only if it has not
been allocated yet for some other llsec_key_id, otherwise its refcount
is incremented. Its lifecycle is managed with llsec_key_{get|put}
primitives. A pointer to this object is passed into
`struct ieee802154_llsec_key_entry`.

So the only way to reach `struct ieee802154_llsec_key_entry` objects is
through the list they belong to and they should be freed when they are
unlinked from the list.

E.g. see mac802154_llsec_destroy() where for &sec->table.keys this
sequence of llsec_key_put() for mkey and kfree_sensitive() for list entry
is done.

> 
> Thanks.
> 
> Otherwise the patch looks correct to me.
> 
> - Alex
> 

--
Fedor

